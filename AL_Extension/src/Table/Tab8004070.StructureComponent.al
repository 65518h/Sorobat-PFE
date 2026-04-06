Table 8004070 "Structure Component"
{
    // //ITEM_DESCRIPTION GESWAY 23/10/02 Passage à 50 de description + "BOM Description"
    // //OUVRAGE GESWAY 29/01/03 Ajout des champs value 1 à 10 + wInitValueCalc + wCalcQty
    //                  15/07/03 Ajout champ "Printed"
    //                  18/08/03 Ajout SETRANGE(Status = Generic) sur Main d'oeuvre et matériel -> wLookupNo
    //                  08/09/03 Ajout champs "Starting Date","Ending Date"
    //                  16/10/03 Prendre l'unité de vente
    //                  24/05/05 Ajout du champ "Number of resources"
    // //ETATS GESWAY 16/07/03 Ajout champ "Print Line on Doc."
    // //SUBCONTRACTOR CLA 10/05/04 Ajout nouveaux champs
    // //+REF+REPLIC AC 28/06/05 OnInsert, OnModify, OnDelete, OnRename
    //                           + field "Replication" (ID = 73754 ), boolean, editable=No
    // //OUVRAGE MB 29/06/06 affichage designation apres selection d'un compte Général

    Caption = 'Structure Composition';
    // DrillDownPageID = 8004070;
    //LookupPageID = 8004070;

    fields
    {
        field(1; "Parent Structure No."; Code[20])
        {
            Caption = 'Parent Structure No.';
            NotBlank = true;
            TableRelation = Resource;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Person,Machine,Structure,G/L Account';
            OptionMembers = " ",Item,Person,Machine,Structure,"G/L Account","Frais Annexe";

            trigger OnValidate()
            begin
                "No." := '';
                "Variant Code" := '';
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const(Person)) Resource where(Type = filter(Person))
            else
            if (Type = const(Machine)) Resource where(Type = filter(Machine))
            else
            if (Type = const(Structure)) Resource where(Type = filter(Structure))
            else
            if (Type = const("Frais Annexe")) "Item Charge";

            trigger OnLookup()
            var
                lMultiple: Boolean;
            begin
                case Type of
                    Type::Item:
                        wRecordRef.Open(27);
                    Type::Person, Type::Structure, Type::Machine:
                        wRecordRef.Open(156);
                    Type::"Frais Annexe":
                        wRecordRef.Open(5800);
                    else
                        wRecordRef.Open(37);
                end;
                wLookupNo(Rec, wRecordRef, lMultiple);
                //#6902
                wRecordRef.Close();
                //#6902//
            end;

            trigger OnValidate()
            var
                lItemUnitOfMeasure: Record "Item Unit of Measure";
                lFinish: Boolean;
            begin
                TestField(Type);
                if Type = Type::Structure then
                    wRefCircular("Parent Structure No.", "No.", lFinish);

                "Variant Code" := '';
                if "No." = '' then
                    exit;

                case Type of
                    //OUVRAGE
                    Type::"G/L Account":
                        begin
                            GLAcc.Get("No.");
                            Description := GLAcc.Name;
                        end;
                    //OUVRAGE//
                    Type::Item:
                        begin
                            Item.Get("No.");
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            "Value 1" := Item."Default Qty Value 1";
                            "Value 2" := Item."Default Qty Value 2";
                            "Value 3" := Item."Default Qty Value 3";
                            "Value 4" := Item."Default Qty Value 4";
                            "Value 5" := Item."Default Qty Value 5";
                            "Value 6" := Item."Default Qty Value 6";
                            "Value 7" := Item."Default Qty Value 7";
                            "Value 8" := Item."Default Qty Value 8";
                            "Value 9" := Item."Default Qty Value 9";
                            "Value 10" := Item."Default Qty Value 10";

                            //SUBCONTRACTOR
                            Subcontracting := Item.Subcontracting;
                            if (Subcontracting <> 0) then begin
                                ParentRes.Get("Parent Structure No.");
                                if not lItemUnitOfMeasure.Get("No.", ParentRes."Base Unit of Measure") then begin
                                    lItemUnitOfMeasure.Init;
                                    lItemUnitOfMeasure."Item No." := "No.";
                                    lItemUnitOfMeasure.Code := ParentRes."Base Unit of Measure";
                                    lItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
                                    lItemUnitOfMeasure.Insert;
                                end;
                                "Unit of Measure Code" := ParentRes."Base Unit of Measure";
                                "Quantity per" := 1;
                            end else
                                //SUBCONTRACTOR//
                                Validate("Unit of Measure Code", Item."Base Unit of Measure");
                            Item.TestField("Gen. Prod. Posting Group");
                            Item.TestField("VAT Prod. Posting Group");
                        end;
                    Type::Person, Type::Machine, Type::Structure:
                        begin
                            Res.Get("No.");
                            ParentRes.Get("Parent Structure No.");
                            Description := Res.Name;
                            "Description 2" := Res."Name 2";
                            Validate("Unit of Measure Code", Res."Base Unit of Measure");
                            if Type <> Type::Structure then begin
                                "Number of Resources" := Res."Default Number of Resources";
                            end;
                            if Type in [Type::Person, Type::Machine] then
                                Validate("Rate Quantity", Res."Default Rate Quantity");
                            Res.TestField("Gen. Prod. Posting Group");
                            Res.TestField("VAT Prod. Posting Group");
                        end;
                end;
            end;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            Description = 'Navibat';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = filter(Person | Machine | Structure)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure".Code;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8; "Quantity per"; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lQtySetup: Record "Quantity Setup";
            begin
                if lQtySetup.Get then;
                if (FieldNo("Quantity per") = CurrFieldNo) and not (lQtySetup."Formula desactivated / Sales") then begin
                    "Value 1" := 0;
                    "Value 2" := 0;
                    "Value 3" := 0;
                    "Value 4" := 0;
                    "Value 5" := 0;
                    "Value 6" := 0;
                    "Value 7" := 0;
                    "Value 8" := 0;
                    "Value 9" := 0;
                    "Value 10" := 0;
                end;

                if ParentRes."No." <> "Parent Structure No." then
                    ParentRes.Get("Parent Structure No.");

                if not (Type in [Type::Person, Type::Machine]) then
                    "Rate Quantity" := 0
                else
                    if ParentRes.Rate <> 0 then
                        "Rate Quantity" := "Quantity per" * ParentRes.Rate;
            end;
        }
        field(9; Position; Code[10])
        {
            Caption = 'Position';
        }
        field(10; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
        }
        field(11; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
        }
        field(12; "Machine No."; Code[10])
        {
            Caption = 'Machine No.';
        }
        field(13; "Production Lead Time"; Integer)
        {
            Caption = 'Production Lead Time';
        }
        field(14; "BOM Description"; Text[100])
        {
            CalcFormula = lookup(Resource.Name where("No." = field("Parent Structure No.")));
            Caption = 'BOM Description';
            Description = 'Navibat';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));

            trigger OnValidate()
            begin
                if "Variant Code" = '' then
                    exit;
                TestField(Type, Type::Item);
                TestField("No.");
                ItemVariant.Get("No.", "Variant Code");
                Description := ItemVariant.Description;
            end;
        }
        field(5900; "Installed in Line No."; Integer)
        {
            Caption = 'Installed in Line No.';

            trigger OnLookup()
            begin
                BOMComp.Reset;
                BOMComp.SetRange("Parent Structure No.", "Parent Structure No.");
                BOMComp.SetRange(Type, BOMComp.Type::Item);
                BOMComp.SetFilter("Line No.", '<>%1', "Line No.");
                //DYS page addon non migrer
                // Clear(BillOfMaterials);
                // BillOfMaterials.SetTableview(BOMComp);
                // BillOfMaterials.Editable(false);
                // BillOfMaterials.LookupMode(true);
                // if BillOfMaterials.RunModal = Action::LookupOK then begin
                //     BillOfMaterials.GetRecord(BOMComp);
                //     Validate("Installed in Line No.", BOMComp."Line No.");
                // end;
            end;

            trigger OnValidate()
            begin
                if "Installed in Line No." <> 0 then begin
                    if "Installed in Line No." = "Line No." then
                        Error(Text000, FieldCaption("Installed in Line No."));
                    BOMComp.Reset;
                    BOMComp.SetRange("Parent Structure No.", "Parent Structure No.");
                    BOMComp.SetRange(Type, BOMComp.Type::Item);
                    BOMComp.SetRange("Line No.", "Installed in Line No.");
                    BOMComp.Find('-');
                    BOMComp.TestField("Quantity per", 1);
                    "Installed in Item No." := BOMComp."No.";
                end else
                    "Installed in Item No." := '';
            end;
        }
        field(5901; "Installed in Item No."; Code[20])
        {
            Caption = 'Installed in Item No.';
            TableRelation = if (Type = const(Item)) Item;

            trigger OnLookup()
            begin
                BOMComp.Reset;
                BOMComp.SetRange("Parent Structure No.", "Parent Structure No.");
                BOMComp.SetRange(Type, BOMComp.Type::Item);
                BOMComp."No." := "Installed in Item No.";
                BOMComp.SetFilter("Line No.", '<>%1', "Line No.");
                //DYS page addon non migrer
                // Clear(BillOfMaterials);
                // BillOfMaterials.SetTableview(BOMComp);
                // BillOfMaterials.Editable(false);
                // BillOfMaterials.LookupMode(true);
                // if BillOfMaterials.RunModal = Action::LookupOK then begin
                //     BillOfMaterials.GetRecord(BOMComp);
                //     Validate("Installed in Line No.", BOMComp."Line No.");
                // end;
            end;

            trigger OnValidate()
            begin
                if "Installed in Item No." <> '' then begin
                    BOMComp.Reset;
                    BOMComp.SetRange("Parent Structure No.", "Parent Structure No.");
                    BOMComp.SetRange(Type, BOMComp.Type::Item);
                    BOMComp.SetRange("No.", "Installed in Item No.");
                    BOMComp.Find('-');
                end;

                Validate("Installed in Line No.", BOMComp."Line No.");
            end;
        }
        field(50000; "Code Etude"; Code[10])
        {

            trigger OnLookup()
            begin
                // >> HJ DSFT 29-06-2012
                GetCodeEtude;
                // >> HJ DSFT 29-06-2012
            end;

            trigger OnValidate()
            begin
                // >> HJ DSFT 29-06-2012
                GetCodeEtude;
                // >> HJ DSFT 29-06-2012
            end;
        }
        field(50001; "Code Element"; Code[20])
        {
        }
        field(50002; "Type Divers"; Option)
        {
            OptionMembers = " ",Divers,Transport,"Sous Traitance";
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8004048; "Number of Resources"; Decimal)
        {
            //blankzero = true;
            Caption = 'Number of Resources';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                if (Type <> Type::Person) and (Type <> Type::Machine) then
                    Error(tPersonOrMachine, Type);
                Validate("Quantity per");
            end;
        }
        field(8004049; "Rate Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Rate Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lNbrResource: Decimal;
            begin
                if not (Type in [Type::Person, Type::Machine]) then
                    FieldError("Rate Quantity", StrSubstNo(tPersonOrMachine, Format(Type)));

                if ParentRes."No." <> "Parent Structure No." then
                    ParentRes.Get("Parent Structure No.");

                lNbrResource := "Number of Resources";

                if ParentRes.Rate <> 0 then
                    "Quantity per" := "Rate Quantity" / ParentRes.Rate;
            end;
        }
        field(8004055; "Fixed Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Fixed Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Quantity per");
            end;
        }
        field(8004066; "Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004067; "Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004068; "Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004069; "Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004070; "Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004071; "Value 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004072; "Value 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004073; "Value 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Value 8';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004074; "Value 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Value 9';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004075; "Value 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Value 10';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyStructure(Rec);
            end;
        }
        field(8004076; "Print Line on Doc."; Boolean)
        {
            Caption = 'Print Line';
        }
        field(8004150; Subcontracting; Option)
        {
            Caption = 'Subcontracting';
            OptionCaption = ' ,Furniture and Fixing,Fixing';
            OptionMembers = " ","Furniture and Fixing",Fixing;
        }
        field(8004152; "Subcontracted quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Subcontracted quantity';
        }
        field(8004153; "Subcontracted Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Subcontracted Unit Cost';
            MinValue = 0;
        }
    }

    keys
    {
        key(STG_Key1; "Parent Structure No.", "Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
        //#6115
        lRecRef.GetTable(Rec);
        lBOQCustMgt.gOndelete(lRecRef, false);
        //#6115//
    end;

    trigger OnInsert()
    var
        lRec: Record "Structure Component";
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//

        //#6115
        lRecRef.GetTable(Rec);
        lBOQCustMgt.gOnInsert(lRecRef);
        //#6115//

        if ("No." = '') then
            exit;

        ParentRes.Get("Parent Structure No.");
        //SUBCONTRACTOR
        if "Line No." = 0 then begin
            lRec.SetCurrentkey("Parent Structure No.");
            lRec.SetRange("Parent Structure No.", "Parent Structure No.");
            if lRec.Find('+') then
                "Line No." := lRec."Line No." + 5001
            else
                "Line No." := 5001;
        end;
        //SUBCONTRACTOR//
    end;

    trigger OnModify()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnRename()
    var
        lReplicationRef: RecordRef;
        lRecRef: RecordRef;
        lxRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#6889
        lRecRef.GetTable(Rec);
        lxRecRef.GetTable(xRec);
        lBOQCustMgt.gOnRenameWithChild(lRecRef, lxRecRef);
        //#6889//
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;

    var
        Text000: label '%1 cannot be component of itself.';
        Item: Record Item;
        ParentRes: Record Resource;
        Res: Record Resource;
        ItemVariant: Record "Item Variant";
        BOMComp: Record "Structure Component";
        wCalcQty: Codeunit "Calculate Quantity";
        Text001: label '%1 must be later than %2.';
        TextMultiple: label 'Insert in progress.';
        wRecordRef: RecordRef;
        tPersonOrMachine: label 'can''t be used for %1 type';
        //DYS page addon non migrer
        // BillOfMaterials: Page 8004080;
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        tErrorRefCirculaire: label 'Circular Reference Error. The structure No.¨%1 can''t apply in %2';
        GLAcc: Record "G/L Account";


    procedure wLookupNo(var rec: Record "Structure Component"; var pRecordRef: RecordRef; var pMultiple: Boolean): Boolean
    var
        lStdText: Record "Standard Text";
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lRes: Record Resource;
        lOK: Boolean;
        lFormRes: Page "Resource List";
        lFormItem: Page "Item List";
        lFormGL: Page "G/L Account List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        LItemCharge: Record "Item Charge";
        LFormItemCharge: Page "Item Charges";
    begin
        ParentRes.Get("Parent Structure No.");
        lOK := false;
        case Type of
            Type::" ":
                begin
                    if "No." <> '' then
                        lStdText.Get("No.");
                    if PAGE.RunModal(0, lStdText) = Action::LookupOK then begin
                        lOK := true;
                        Validate("No.", lStdText.Code);
                    end;
                end;
            Type::"G/L Account":
                begin
                    if "No." <> '' then begin
                        lGLAccount.Get("No.");
                        lFormGL.SetRecord(lGLAccount);
                    end;
                    lFormGL.SetTableview(lGLAccount);
                    lFormGL.LookupMode(true);
                    if lFormGL.RunModal = Action::LookupOK then begin
                        lFormGL.GetRecord(lGLAccount);
                        lOK := true;
                        Validate("No.", lGLAccount."No.");
                    end;
                end;
            Type::"Frais Annexe":
                begin
                    if "No." <> '' then begin
                        LItemCharge.Get("No.");
                        LFormItemCharge.SetRecord(lGLAccount);
                    end;
                    LFormItemCharge.SetTableview(LItemCharge);
                    LFormItemCharge.LookupMode(true);
                    if LFormItemCharge.RunModal = Action::LookupOK then begin
                        LFormItemCharge.GetRecord(LItemCharge);
                        lOK := true;
                        Validate("No.", LItemCharge."No.");
                    end;
                end;

            Type::Item:
                begin
                    if "No." <> '' then begin
                        lItem.Get("No.");
                        lFormItem.SetRecord(lItem);
                    end;
                    if Format(pRecordRef.Number) = '27' then begin
                        lItem.SetFilter("Search Description", CopyStr(pRecordRef.GetFilters, StrPos(pRecordRef.GetFilters, ':') + 1));
                        lItem.SetRange(Subcontracting, 0);
                    end;
                    lFormItem.SetTableview(lItem);
                    lFormItem.LookupMode(true);
                    if lFormItem.RunModal = Action::LookupOK then begin
                        lFormItem.wSetSelectionFilter(lItem);
                        if lItem.Count = 1 then begin
                            lFormItem.GetRecord(lItem);
                            Validate("No.", lItem."No.");
                        end
                        else begin
                            lFenetre.Open(TextMultiple);
                            lGetRecord.SetStructure(ParentRes);
                            lGetRecord.SetStructureLine(rec);
                            lGetRecord.CreateStructLinesFromItem(lItem);
                            pMultiple := true;
                            lFenetre.Close;
                        end;
                        lOK := true;
                    end;
                end;
            Type::Person:
                wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Person, lRes.Status::Generic);
            Type::Machine:
                wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Machine, lRes.Status::Generic);
            Type::Structure:
                wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Structure, 9);
        end;
        exit(lOK);
    end;


    procedure wLookupResource(var rec: Record "Structure Component"; var pRecordRef: RecordRef; var pMultiple: Boolean; var pOK: Boolean; pType: Integer; pStatus: Integer)
    var
        lRes: Record Resource;
        lFormRes: Page "Resource List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
    begin
        ParentRes.Get("Parent Structure No.");
        lRes.SetCurrentkey(Type, "No.");
        lRes.SetRange(Type, pType);
        if pStatus <> 9 then
            lRes.SetRange(Status, pStatus);
        if not lRes.Find('-') then
            lRes.SetRange(Status);
        if "No." <> '' then begin
            lRes.Get("No.");
            lFormRes.SetRecord(lRes);
        end;
        if Format(pRecordRef.Number) = '156' then begin
            lRes.SetFilter("Search Name", CopyStr(pRecordRef.GetFilters, StrPos(pRecordRef.GetFilters, ':') + 1));
            if Type = Type::Structure then
                lRes.SetRange(Subcontracting, 0);
        end;
        lFormRes.SetTableview(lRes);
        lFormRes.LookupMode(true);
        if lFormRes.RunModal = Action::LookupOK then begin
            lFormRes.wSetSelectionFilter(lRes);
            if lRes.Count = 1 then begin
                lFormRes.GetRecord(lRes);
                Validate("No.", lRes."No.");
            end
            else begin
                lFenetre.Open(TextMultiple);
                lGetRecord.SetStructure(ParentRes);
                lGetRecord.SetStructureLine(rec);
                lGetRecord.CreateStructLinesFromRes(lRes);
                pMultiple := true;
                lFenetre.Close;
            end;
            pOK := true;
        end;
    end;


    procedure wLookupItem(var rec: Record "Structure Component"; var pRecordRef: RecordRef; var pMultiple: Boolean; pSubcontracting: Option " ","Furniture and Fixing",Fixing): Boolean
    var
        lStdText: Record "Standard Text";
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lRes: Record Resource;
        lOK: Boolean;
        lFormRes: Page "Resource List";
        lFormItem: Page "Item List";
        lFormGL: Page "G/L Account List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
    begin
        ParentRes.Get("Parent Structure No.");
        lOK := false;
        if "No." <> '' then begin
            lItem.Get("No.");
            lFormItem.SetRecord(lItem);
        end;
        lItem.SetFilter("Search Description", CopyStr(pRecordRef.GetFilters, StrPos(pRecordRef.GetFilters, ':') + 1));
        lItem.SetCurrentkey(Subcontracting);
        if pSubcontracting <> 0 then
            lItem.SetRange(Subcontracting, pSubcontracting)
        else
            lItem.SetRange(Subcontracting, pSubcontracting);
        lFormItem.SetTableview(lItem);
        lFormItem.LookupMode(true);
        if lFormItem.RunModal = Action::LookupOK then begin
            lFormItem.wSetSelectionFilter(lItem);
            if pSubcontracting <> 0 then begin
                lFormItem.GetRecord(lItem);
                Type := Type::Item;
                Validate("No.", lItem."No.");
            end else
                if lItem.Count = 1 then begin
                    lFormItem.GetRecord(lItem);
                    Validate("No.", lItem."No.");
                end else begin
                    lFenetre.Open(TextMultiple);
                    lGetRecord.SetStructure(ParentRes);
                    lGetRecord.SetStructureLine(rec);
                    lGetRecord.CreateStructLinesFromItem(lItem);
                    pMultiple := true;
                    lFenetre.Close;
                end;
            lOK := true;
        end;
        exit(lOK);
    end;

    local procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        if not lQtySetup.Get then
            lQtySetup.Init;
        if lQtySetup."Value 1 Name" = '' then
            lQtySetup."Value 1 Name" := FieldCaption("Value 1");
        if lQtySetup."Value 2 Name" = '' then
            lQtySetup."Value 2 Name" := FieldCaption("Value 2");
        if lQtySetup."Value 3 Name" = '' then
            lQtySetup."Value 3 Name" := FieldCaption("Value 3");
        if lQtySetup."Value 4 Name" = '' then
            lQtySetup."Value 4 Name" := FieldCaption("Value 4");
        if lQtySetup."Value 5 Name" = '' then
            lQtySetup."Value 5 Name" := FieldCaption("Value 5");
        if lQtySetup."Value 6 Name" = '' then
            lQtySetup."Value 6 Name" := FieldCaption("Value 6");
        if lQtySetup."Value 7 Name" = '' then
            lQtySetup."Value 7 Name" := FieldCaption("Value 7");
        if lQtySetup."Value 8 Name" = '' then
            lQtySetup."Value 8 Name" := FieldCaption("Value 8");
        if lQtySetup."Value 9 Name" = '' then
            lQtySetup."Value 9 Name" := FieldCaption("Value 9");
        if lQtySetup."Value 10 Name" = '' then
            lQtySetup."Value 10 Name" := FieldCaption("Value 10");

        case FieldNumber of
            1:
                exit('8004050,' + lQtySetup."Value 1 Name");
            2:
                exit('8004050,' + lQtySetup."Value 2 Name");
            3:
                exit('8004050,' + lQtySetup."Value 3 Name");
            4:
                exit('8004050,' + lQtySetup."Value 4 Name");
            5:
                exit('8004050,' + lQtySetup."Value 5 Name");
            6:
                exit('8004050,' + lQtySetup."Value 6 Name");
            7:
                exit('8004050,' + lQtySetup."Value 7 Name");
            8:
                exit('8004050,' + lQtySetup."Value 8 Name");
            9:
                exit('8004050,' + lQtySetup."Value 9 Name");
            10:
                exit('8004050,' + lQtySetup."Value 10 Name");
        end;
    end;


    procedure wRefCircular(pNoRef: Code[20]; pNoStructure: Code[20]; var pFinish: Boolean)
    var
        lStructure: Record "Structure Component";
    begin
        if pNoStructure = pNoRef then
            Error(tErrorRefCirculaire, pNoStructure);
        if pFinish then begin
            exit;
        end else begin
            lStructure.SetRange("Parent Structure No.", pNoStructure);
            lStructure.SetRange(Type, lStructure.Type::Structure);
            if lStructure.IsEmpty then
                exit
            else begin
                lStructure.Find('-');
                repeat
                    wRefCircular(pNoRef, lStructure."No.", pFinish);
                until lStructure.Next = 0;
            end;
        end;
    end;


    procedure wCopyBOQ(pRec: Record "Structure Component")
    var
        lToFatherRef: RecordRef;
        lToRecRef: RecordRef;
        lFromFatherRef: RecordRef;
        lFromRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lBOQMgt: Codeunit "BOQ Management";
        l156: Record Resource;
    begin
        if pRec.Type <> pRec.Type::Structure then
            exit;

        l156.Get(pRec."No.");
        lFromFatherRef.GetTable(l156);
        lFromRecRef := lFromFatherRef.Duplicate;

        l156.Get(pRec."Parent Structure No.");
        lToFatherRef.GetTable(l156);
        lToRecRef.GetTable(pRec);
        if not lBOQMgt.Load(lToFatherRef.RecordId) then begin
            lBOQCustMgt.gLoadResourceBOQ(l156);
            lBOQMgt.Save('');
        end;
        if lBOQMgt.CopyBOQFrom(lFromFatherRef.RecordId, lFromRecRef.RecordId, lToFatherRef.RecordId, lToRecRef.RecordId, false) then begin
            lBOQMgt.Save('');
            //  lBOQCustMgt.fCalcBOQRef(lToRecRef,FALSE,FALSE);
        end;
    end;


    procedure "// HJ DSFT"()
    begin
    end;


    procedure GetCodeEtude()
    var
        RecLItem: Record Item;
        RecLResource: Record Resource;
    begin
        // >> HJ DSFT 29-06-2012
        RecLItem.Reset;
        RecLResource.Reset;
        if Type = Type::Item then begin
            RecLItem.SetFilter("Code Etude", '%1', '*' + "Code Etude" + '*');
            if PAGE.RunModal(page::"Article Par Code Etude", RecLItem) = Action::LookupOK then begin
                Validate("No.", RecLItem."No.");
                "Code Etude" := RecLItem."Code Etude";
            end;
        end;
        if Type = Type::Person then begin
            RecLResource.SetFilter("Code Etude", '%1', '*' + "Code Etude" + '*');
            RecLResource.SetRange(Type, RecLResource.Type::Person);
            if PAGE.RunModal(page::"Resource Par Code Etude", RecLResource) = Action::LookupOK then begin
                Validate("No.", RecLResource."No.");
                "Code Etude" := RecLResource."Code Etude";
            end;
        end;
        if Type = Type::Machine then begin
            RecLResource.SetFilter("Code Etude", '%1', '*' + "Code Etude" + '*');
            RecLResource.SetRange(Type, RecLResource.Type::Machine);
            if PAGE.RunModal(page::"Resource Par Code Etude", RecLResource) = Action::LookupOK then begin
                Validate("No.", RecLResource."No.");
                "Code Etude" := RecLResource."Code Etude";
            end;

        end;

        // >> HJ DSFT 29-06-2012
    end;
}

