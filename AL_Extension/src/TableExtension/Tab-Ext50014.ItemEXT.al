TableExtension 50014 ItemEXT extends Item
{
    fields
    {

        /*  modify(Description)
          {
              Description = 'Navibat';
              trigger OnBeforeValidate()
              begin
                  //>> SAY 11-10-2018 V‚rification CaractŠre
                  Vérifcara('#', Description);
                  //>> SAY 11-10-2018 V‚rification CaractŠre
              end;
          }*/
        modify("No.")
        {
            trigger OnBeforeValidate()
            begin

                //>> HJ DSFT 31-01-2013
                //GL2025 IF STRLEN("No.") <> 13 THEN ERROR(Text027);
                //>> HJ DSFT 31-01-2013
            end;
        }
        modify("Description 2")
        {
            Description = 'Navibat';

        }



        modify("Costing Method")
        {
            trigger OnBeforeValidate()
            begin

                //#5913
                ////#5704
                //IF "Costing Method" = "Costing Method"::Standard THEN
                //  FIELDERROR("Costing Method",STRSUBSTNO(tGenericCostingMethod,FIELDCAPTION("Item Type"),"Item Type"));
                ////#5704//
                IF ("Costing Method" = "Costing Method"::Standard) AND ("Item Type" = "Item Type"::Generic) THEN
                    FIELDERROR("Costing Method", STRSUBSTNO(tGenericCostingMethod, FIELDCAPTION("Item Type"), "Item Type"));
                //#5913//
            end;

        }
        /*//GL2024   Il est impossible de rendre un champ modifiable (editable) lorsqu'un champ standard est modifié
        modify("Last Direct Cost")
        {
            Editable = true;
        }*/




        modify("Vendor No.")
        {
            TableRelation = if (Subcontracting = filter(<> " ")) Vendor where(Subcontractor = const(true))
            else
            Vendor;
            Description = 'Modification TableRelation';



        }



        modify("Gen. Prod. Posting Group")
        {
            trigger OnAfterValidate()
            var
                RecLProductPostingGroup: Record "Gen. Product Posting Group";
            begin
                if RecLProductPostingGroup.get(rec."Gen. Prod. Posting Group") then begin
                    rec.ValidateShortcutDimCode(4, RecLProductPostingGroup."Global Dimension 4 Code");
                end;
            end;
        }
        // modify("Item Category Code")
        // {
        //     //CaptionClass = '8001400,1,5722';
        // }

        modify("Inventory Value Zero")
        {
            trigger OnafterValidate()
            var

                TInventoryValue: label '%1 cannot be false for an item type generic.';
            begin
                //#9169
                IF ("Item Type" = "Item Type"::Generic) AND (NOT "Inventory Value Zero") THEN
                    ERROR(TInventoryValue, FIELDCAPTION("Inventory Value Zero"));
                //#9169//
            end;
        }


        field(50000; "Date Creation"; Date)
        {
            Description = 'HJ DSFT 22-03-2012';
        }
        field(50001; Statut; Option)
        {
            Description = 'HJ DSFT 24 03 2012';
            Editable = false;
            OptionMembers = "En Attente","Validé";

            trigger OnValidate()
            begin
                //GL2024   CheckFields;
            end;
        }
        field(50002; "PV Reception Requis"; Boolean)
        {
            Description = 'HJ DSFT 26-04-2012';
        }
        field(50003; "Code Etude"; Code[10])
        {
            Caption = 'Code Etude';
            Description = 'HJ DSFT 26-06-2012';
        }
        field(50004; Synchronise; Boolean)
        {
        }
        field(50005; "Num Sequence Syncro"; Integer)
        {

        }
        field(50006; "Nom Famille"; Text[80])
        {
            CalcFormula = lookup(Tree.Description where(Type = const(Item),
                                                         Code = field("Tree Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; Fourniture; Decimal)
        {

            trigger OnValidate()
            begin
                CalculerCoutMateriaux;
            end;
        }
        field(50008; Transport; Decimal)
        {

            trigger OnValidate()
            begin
                CalculerCoutMateriaux;
            end;
        }
        field(50009; "% Perte"; Decimal)
        {

            trigger OnValidate()
            begin
                CalculerCoutMateriaux;
            end;
        }
        field(50010; Perte; Decimal)
        {
        }
        field(50011; "Cout Materiaux"; Decimal)
        {
        }
        field(50012; Rendement; Decimal)
        {
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                CalculerCoutMateriaux;
            end;
        }
        field(50013; "Cout Sans Rendement"; Decimal)
        {
        }
        field(50019; "N° Dossier (PRR)"; Code[20])
        {
            Editable = false;
            //GL2024  TableRelation = Table0;
        }
        field(50020; "Date dossier (PRR)"; Date)
        {
        }
        field(50021; "Filtre Date Stock"; Date)
        {
            //FieldClass = FlowFilter;
        }
        field(50022; "Type Lié Ouvrage"; Option)
        {
            OptionMembers = " ",Divers,Transport,"Sous Traitance";
        }
        field(50023; "Rapport Journalier"; Boolean)
        {
        }
        field(50024; "Seuil Min"; Integer)
        {

            trigger OnValidate()
            begin
                "Seuil Max" := "Seuil Min";
            end;
        }
        field(50025; "Appliquer Redevance"; Boolean)
        {
        }
        field(50026; "Montant Redevance"; Decimal)
        {
        }
        field(50027; "Appliquer FS"; Boolean)
        {
        }
        field(50028; "Montant FS"; Decimal)
        {
        }
        field(50029; "Seuil Max"; Integer)
        {

            trigger OnValidate()
            begin
                //    if "Seuil Max" = 0 then Error(Text028);
            end;
        }
        field(50030; "Alerte Declenche"; Boolean)
        {
            Description = 'HJ SORO 10-06-2015';
        }
        field(50031; "Relation Volume / Tonnage"; Decimal)
        {
            Description = 'HJ SORO 02-07-2015';
        }
        /*  field(50032; "Emplacement BEJA LOT2"; Text[30])
          {
              Description = 'HJ SORO 02-07-2015';
              TableRelation = Emplacement where(Magasin = filter('BEJALOT2'));
          }
          field(50033; "Emplacement BEJA LOT3"; Text[30])
          {
              Description = 'HJ SORO 02-07-2015';
              TableRelation = Emplacement where(Magasin = filter('BEJALOT3'));
          }*/
        field(50034; "Quantité Commandé"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Quantity (Base)" where("No." = field("No.")));
            Description = 'HJ SORO 10-08-2016';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Quantité Reçue"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Qty. Received (Base)" where("No." = field("No."),
                                                                            "Quantity Received" = filter(<> 0)));
            Description = 'HJ SORO 10-08-2016';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50036; "Quantité Restante"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Outstanding Quantity" = filter(<> 0),
                                                                               "No." = field("No.")));
            Description = 'HJ SORO 10-08-2016';
            Editable = false;
            FieldClass = FlowField;
        }
        /*  field(50037; "Rapport Journalier"; Boolean)
          {
              Description = 'HJ SORO 10-08-2016';
          }
          field(50038; "Alerte Declenche"; Boolean)
          {
              Description = 'HJ SORO 10-06-2015';
          }
          field(50039; "Remblais/Deblais"; Option)
          {
              Description = 'HJ SORO 06-06-2017';
              OptionMembers = " ",Remblais,Deblais;
          }
          field(50040; "Filtre Date Stock"; Date)
          {
              FieldClass = FlowFilter;
          }*/
        field(50041; "Type Operation"; Option)
        {
            Description = 'HJ SORO 17-01-2018';
            OptionMembers = " ",D,M;
        }
        field(50042; Coeficient; Decimal)
        {
            Description = 'HJ SORO 17-01-2018';
        }
        field(50043; Cocher_Appro; Boolean)
        {
            Description = 'MH-SORO 08-02-2021';
        }
        field(50044; Observation_Appro; Text[250])
        {
            Description = 'MH-SORO 08-02-2021';
        }
        field(50045; "Integrer Offre dr Prix"; Boolean)
        {
            Description = 'MH-SORO 30-05-2022';
        }
        field(50100; "Type Carte"; Option)
        {
            Description = 'HJ DSFT 19 04 2012';
            OptionCaption = ' ,Carte Carburant,Carte Autoroute';
            OptionMembers = " ","Carte Carburant","Carte Autoroute";
        }
        field(50101; "DA Lancé"; Boolean)
        {
            Editable = true;
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Line" WHERE(Type = CONST(Item),
                                                                                         Statut = FILTER(Lancé),
                                                                                         "No." = FIELD("No.")));
        }
        field(50102; Dosage; Integer)
        {
            Editable = true;
        }
        field(50103; Type2; Option)
        {
            Editable = true;
            OptionMembers = " ","Pompé","Non Pompé","Sous-Tremie";
        }
        field(50104; Adjuvant; Option)
        {
            Editable = true;
            Enabled = true;
            OptionMembers = " ","Avec Adjuvant","Sans Adjuvant";
        }
        /*   field(50105; "DA Lancé"; Boolean)
           {
               CalcFormula = exist("Sales Line" where(Type = const(Item),
                                                       Statut = filter(Lancé),
                                                       "No." = field("No.")));
               Editable = false;
               FieldClass = FlowField;
           }*/
        field(50146; "Approval threshold requisition"; Decimal)
        {
            Caption = 'Approval threshold requisition';
            DecimalPlaces = 3 : 3;
            Description = '//AGA DSFT 12 07 2010';
        }
        field(50147; "Approbation requise"; Boolean)
        {
            Description = '//AGA DSFT 12 07 2010';
        }
        field(50148; "Emplacement"; Text[100])
        {

        }
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        /*  field(50149; "Emplacement Bati Depot z4"; Text[30])
          {
              Description = 'HJ DSFT 30 01 2013';
              TableRelation = Emplacement where(Magasin = filter('BATI DEPOT'));

              trigger OnValidate()
              begin
                  CuItemJnlPostLineEmpl.UpdateEmplacement("No.", 'MGHLOT13', "Emplacement Bati Depot z4");
              end;
          }
          field(50150; "Emplacement MGH 113"; Text[30])
          {
              Description = 'HJ DSFT 30 01 2013';
              TableRelation = Emplacement where(Magasin = filter('BATMGIRALO'));

              trigger OnValidate()
              begin
                  CuItemJnlPostLineEmpl.UpdateEmplacement("No.", 'BATMGIRALO', "Emplacement MGH 113");
              end;
          }
          field(50151; "Emplacement MGH 51"; Text[30])
          {
              Description = 'HJ DSFT 30 01 2013';
              TableRelation = Emplacement where(Magasin = filter('MGHLOT51'));

              trigger OnValidate()
              begin
                  CuItemJnlPostLineEmpl.UpdateEmplacement("No.", 'MGHLOT51', "Emplacement MGH 51");
              end;
          }*/
        field(50152; "Calculer Cout Transport"; Boolean)
        {
            Description = 'RB SORO 28/04/2015';
        }
        field(50153; "Calculer Cout Transport Soutre"; Boolean)
        {
            Description = 'RB SORO 28/04/2015';
        }
        /*  field(50999; "Num Sequence Syncro"; Integer)
          {
              Description = 'RB SORO 06/03/2015';
              //This property is currently not supported
              //TestTableRelation = false;
              //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
              //ValidateTableRelation = false;
          }*/



        field(51002; "Search Description Soroubat"; Text[200])
        {
            Caption = 'Search Description Soroubat';
        }
        field(51003; "Dernier date achat"; Date)
        {
            Caption = 'Dernier Date d''achat';
            Editable = false;
            FieldClass = flowfield;

            CalcFormula = max("Purch. Inv. Line"."Posting Date" where("No." = field("No.")));
        }
        field(51004; "Dernier Prix achat"; Decimal)
        {
            Caption = 'Dernier Prix d''achat';
            Editable = false;
            FieldClass = flowfield;

            CalcFormula = lookup("Purch. Inv. Line"."Unit Cost (LCY)" where("No." = field("No."), "Posting Date" = field("Dernier date achat")));
        }
        field(51005; "Dernier date achats"; Date)
        {
            Caption = 'Dernier Date d''achat';
            Editable = false;

        }
        field(51006; "Dernier Prix achats"; Decimal)
        {
            Caption = 'Dernier Prix d''achat';
            Editable = false;

        }
        field(51007; "Dernier Entree"; Integer)
        {
            Caption = 'Dernière entrée';
            Editable = false;
            FieldClass = flowfield;

            CalcFormula = max("value Entry"."Entry No." where("Item No." = field("No."), "Item Ledger Entry Type" = filter(Purchase | "Positive Adjmt."), "Cost per Unit" = filter(<> 0)));
        }
        field(51008; "Dernier Prix achat 2"; Decimal)
        {
            Caption = 'Dernier Prix d''achat';
            Editable = false;
            FieldClass = flowfield;
            CalcFormula = sum("value Entry"."Cost per Unit" where("Item No." = field("No."), "Entry No." = field("Dernier Entree"), "Item Ledger Entry Type" = filter(Purchase | "Positive Adjmt.")));
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8001301; "Criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99030';
            Caption = 'Criteria 1';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001301));

        }
        field(8001302; "Criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99031';
            Caption = 'Criteria 2';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001302));
        }
        field(8001303; "Criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99032';
            Caption = 'Criteria 3';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001303));
        }
        field(8001304; "Criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99033';
            Caption = 'Criteria 4';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001304));
        }
        field(8001305; "Criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99034';
            Caption = 'Criteria 5';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001305));
        }
        field(8001306; "Criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99035';
            Caption = 'Criteria 6';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001306));
        }
        field(8001307; "Criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99036';
            Caption = 'Criteria 7';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001307));
        }
        field(8001308; "Criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99037';
            Caption = 'Criteria 8';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001308));
        }
        field(8001309; "Criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99038';
            Caption = 'Criteria 9';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001309));
        }
        field(8001310; "Criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99039';
            Caption = 'Criteria 10';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001310));
        }
        field(8001405; "Characteristic 1"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(1);
            Caption = 'Characteristic 1';
        }
        field(8001406; "Characteristic 2"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(2);
            Caption = 'Characteristic 2';
        }
        field(8001407; "Characteristic 3"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(3);
            Caption = 'Characteristic 3';
        }
        field(8001408; "Characteristic 4"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(4);
            Caption = 'Characteristic 4';
        }
        field(8001409; "Characteristic 5"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(5);
            Caption = 'Characteristic 5';
        }
        field(8001410; "Characteristic 6"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(6);
            Caption = 'Characteristic 6';
        }
        field(8001411; "Characteristic 7"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(7);
            Caption = 'Characteristic 7';
        }
        field(8001412; "Characteristic 8"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(8);
            Caption = 'Characteristic 8';
        }
        field(8001413; "Characteristic 9"; Text[20])
        {
            //CaptionClass = wGetCaptionClass(9);
            Caption = 'Characteristic 9';
        }
        field(8003900; "Purchasing Code2"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(8003901; "Job No. Filter"; Code[20])
        {
            Caption = 'Job No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Job;
        }
        field(8003902; "Best Discount"; Decimal)
        {
            //blankzero = true;
            // CalcFormula = max("Purchase Line Discount"."Line Discount %" where(Type = const("Item Disc. Group"),
            //                                                                    "Item No." = field("Item Disc. Group"),
            //                                                                     "Cost Filter" = field("Public Price")));
            // Caption = 'Best Discount';
            // DecimalPlaces = 0 : 2;
            // FieldClass = FlowField;
        }
        field(8003904; "Best Register Cost"; Decimal)
        {
            //blankzero = true;
            CalcFormula = min("Value Entry"."Cost per Unit" where("Item No." = field("No."),
                                                                   "Item Ledger Entry Type" = const(Purchase),
                                                                   "Entry Type" = const("Direct Cost"),
                                                                   "Source Type" = const(Vendor),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                   "Location Code" = field("Location Filter"),
                                                                   "Cost per Unit" = filter(> 0)));
            Caption = 'Best Register Cost';
            FieldClass = FlowField;
        }
        field(8003915; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionCaption = ' ,Specific,Generic';
            OptionMembers = " ",Specific,Generic;

            trigger OnValidate()
            var
                lItemLedgerEntry: Record "Item Ledger Entry";

                Text003: label 'Do you want to change %1?';
            begin
                if "Item Type" in ["item type"::Specific, "item type"::Generic] then
                    TestField("Shelf No.", '');

                //#7110
                lItemLedgerEntry.SetCurrentkey("Item No.", "Posting Date");
                lItemLedgerEntry.SetRange("Item No.", "No.");
                if not lItemLedgerEntry.IsEmpty then
                    Error(StrSubstNo(Text8003915, FieldCaption("Item Type"), Format("No.")));
                //#7110//

                //#5913
                ////#5704
                //IF "Item Type"  = "Item Type"::Generic THEN
                //  FIELDERROR("Item Type",STRSUBSTNO(tGenericCostingMethod,FIELDCAPTION("Costing Method"),"Costing Method"));
                ////#5704//
                if ("Item Type" = "item type"::Generic) and ("Costing Method" = "costing method"::Standard) then begin
                    Message('%1',
                      StrSubstNo('%1 %2 ', FieldCaption("Item Type"), "Item Type") +
                      StrSubstNo(tGenericCostingMethod, FieldCaption("Costing Method"), "Costing Method"));
                    "Costing Method" := "costing method"::FIFO;
                    if Confirm(Text003, true,
                      StrSubstNo('%1 %2', FieldCaption("Costing Method"), "Costing Method")) = true then
                        Validate("Costing Method", "costing method"::FIFO)
                    else
                        Error('');
                end;
                //#5913//

                //#9169
                if ("Item Type" = "item type"::Generic) then
                    "Inventory Value Zero" := true;
                //#9169//
            end;
        }
        field(8003916; "Public Price"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Public Pricepublic';
        }
        field(8003929; "Tree Code"; Text[20])
        {
            Caption = 'Code famille';
            TableRelation = Tree.Code where(Type = const(Item));

            trigger OnLookup()
            var
                lPyramid: Record Tree;
            begin
                /*
                lPyramid.SETRANGE(Type,lPyramid.Type::Item);
                lPyramid.SETFILTER(Code,"Tree Code");
                IF lPyramid.FIND('-') THEN;
                lPyramid.SETRANGE(Code);
                lPyramid.Type := lPyramid.Type::Item;
                "Tree Code" := lPyramid.LookUpForm("Tree Code");
                */
                lPyramid.OnLookUp(lPyramid.Type::Item, "Tree Code")

            end;

            trigger OnValidate()
            var
                lPyramid: Record Tree;
            begin
                /*
                lPyramid.SETRANGE(Type,lPyramid.Type::Item);
                lPyramid.SETFILTER(Code,"Tree Code" + '.*');
                IF lPyramid.FIND('-') THEN
                  ERROR(tNotLowerLevel);
                */
                lPyramid.OnValidate(lPyramid.Type::Item, "Tree Code");

            end;
        }
        field(8003930; "Qty. on Purchase Quote"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Quantity (Base)" where("Document Type" = filter(Quote),
                                                                       "Attached to Doc. No." = filter(''),
                                                                       Type = filter(Item),
                                                                       "No." = field("No.")));
            Caption = 'Qty. on Purchase Quote';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003931; "Default Qty Value 1"; Decimal)
        {
            //blankzero = true;
            //GL2024   //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Default Qty Value 1';
            DecimalPlaces = 0 : 5;
        }
        field(8003932; "Default Qty Value 2"; Decimal)
        {
            //blankzero = true;
            //GL2024   //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Default Qty Value 2';
            DecimalPlaces = 0 : 5;
        }
        field(8003933; "Default Qty Value 3"; Decimal)
        {
            //blankzero = true;
            //GL2024  //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Default Qty Value 3';
            DecimalPlaces = 0 : 5;
        }
        field(8003934; "Default Qty Value 4"; Decimal)
        {
            //blankzero = true;
            //GL2024    //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Default Qty Value 4';
            DecimalPlaces = 0 : 5;
        }
        field(8003935; "Default Qty Value 5"; Decimal)
        {
            //blankzero = true;
            //GL2024  //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Default Qty Value 5';
            DecimalPlaces = 0 : 5;
        }
        field(8003936; "Default Qty Value 6"; Decimal)
        {
            //blankzero = true;
            //GL2024   //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Default Qty Value 6';
            DecimalPlaces = 0 : 5;
        }
        field(8003937; "Default Qty Value 7"; Decimal)
        {
            //blankzero = true;
            //GL2024  //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Default Qty Value 7';
            DecimalPlaces = 0 : 5;
        }
        field(8003938; "Default Qty Value 8"; Decimal)
        {
            //blankzero = true;
            //GL2024   //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Default Qty Value 8';
            DecimalPlaces = 0 : 5;
        }
        field(8003939; "Default Qty Value 9"; Decimal)
        {
            //blankzero = true;
            //GL2024  //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Default Qty Value 9';
            DecimalPlaces = 0 : 5;
        }
        field(8003940; "Default Qty Value 10"; Decimal)
        {
            //blankzero = true;
            //GL2024  //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Default Qty Value 10';
            DecimalPlaces = 0 : 5;
        }
        field(8003950; "Invoicing Unit"; Code[10])
        {
            Caption = 'Invoicing Unit';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));

            trigger OnValidate()
            var

                ItemUnitOfMeasure: Record "Item Unit of Measure";
            begin
                //ACHATS
                if "Invoicing Unit" <> '' then
                    if ItemUnitOfMeasure.Get("No.", "Invoicing Unit") then
                        "Qty. Per Invoicing Unit" := ItemUnitOfMeasure."Qty. per Unit of Measure"
                    else
                        "Qty. Per Invoicing Unit" := 1
                else
                    "Qty. Per Invoicing Unit" := 1;
                //ACHATS//
            end;
        }
        field(8003951; "Qty. Per Invoicing Unit"; Decimal)
        {
            Caption = 'Qty. Per Invoicing Unit';
        }
        field(8003952; "Tariff Article"; Code[20])
        {
            Caption = 'Tariff Article';
            TableRelation = Item."No.";
        }
        field(8004150; Subcontracting; Option)
        {
            Caption = 'Subcontracting';
            OptionCaption = ' ,Furniture and Fixing,Fixing';
            OptionMembers = " ","Furniture and Fixing",Fixing;
        }
    }
    keys
    {
        key(STG_Key20; "Tree Code")
        {
        }
        key(STG_Key21; Subcontracting)
        {
        }

        key(STG_Key22; "Item Disc. Group")
        {
        }
        key(STG_Key23; Synchronise)
        {
        }
        /*  key(STG_Key24; "Emplacement DEPOT Z4")
          {
          }
          key(STG_Key25; "Ancien Code")
          {
          }*/
        key(STG_Key26; "Seuil Min")
        {
        }
    }



    trigger OnbeforeInsert()
    var
        lItemUnitOfMeasure: Record "Item Unit of Measure";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //+REF+TEMPLATE
        IF ("No." = '') AND ("No. Series" <> '') THEN
            NoSeriesMgt.InitSeries("No. Series", "No. Series", 0D, "No.", "No. Series");
        //+REF+TEMPLATE//
    end;

    trigger OnafterInsert()
    var
        lItemUnitOfMeasure: Record "Item Unit of Measure";
    begin

        //+REF+TEMPLATE
        //DimMgt.UpdateDefaultDim(
        //  DATABASE::Item,"No.",
        //  "Global Dimension 1 Code","Global Dimension 2 Code");
        DimMgt.fSetDefaultDim(DATABASE::Item, "No.", 1, "Global Dimension 1 Code");
        DimMgt.fSetDefaultDim(DATABASE::Item, "No.", 2, "Global Dimension 2 Code");
        //+REF+TEMPLATE//
        //+REF+UNIT
        IF "Base Unit of Measure" <> '' THEN BEGIN
            lItemUnitOfMeasure.INIT;
            lItemUnitOfMeasure."Item No." := "No.";
            lItemUnitOfMeasure.Code := "Base Unit of Measure";
            lItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
            IF lItemUnitOfMeasure.INSERT THEN
                VALIDATE("Base Unit of Measure");
        END;
        //+REF+UNIT//

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;




    trigger OnafterModify()
    var
        lReplicationRef: RecordRef;
    begin
        Synchronise := FALSE;
        "Last Date Modified" := WORKDATE;

        PlanningAssignment.ItemChange(Rec, xRec);
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        lReplicationRef.GETTABLE(xRec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
        Synchronise := FALSE;
    end;



    trigger OnbeforeDelete()
    var

        Text023: label 'You cannot delete %1 %2 because there is at least one %3 that includes this item.';
    begin
        BOMComp.RESET;
        BOMComp.SETCURRENTKEY(Type, "No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        BOMComp.SETRANGE("No.", "No.");
        IF BOMComp.FIND('-') THEN
            ERROR(Text023, TABLECAPTION, "No.", BOMComp.TABLECAPTION);

    end;

    trigger OnafterDelete()
    var
        lStructureComponent: Record "Structure Component";
        //GL2024  lItemCrossRef: Record 5717;
        lItemCrossRef: Record "Item Reference";
    begin
        //DELETE
        lItemCrossRef.SETRANGE("Item No.", "No.");
        IF NOT lItemCrossRef.ISEMPTY THEN
            lItemCrossRef.DELETEALL;

        //DELETE//

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnafterRename()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;




    local procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        if not lQtySetup.Get then
            lQtySetup.Init;
        if lQtySetup."Value 1 Name" = '' then
            lQtySetup."Value 1 Name" := FieldCaption("Default Qty Value 1");
        if lQtySetup."Value 2 Name" = '' then
            lQtySetup."Value 2 Name" := FieldCaption("Default Qty Value 2");
        if lQtySetup."Value 3 Name" = '' then
            lQtySetup."Value 3 Name" := FieldCaption("Default Qty Value 3");
        if lQtySetup."Value 4 Name" = '' then
            lQtySetup."Value 4 Name" := FieldCaption("Default Qty Value 4");
        if lQtySetup."Value 5 Name" = '' then
            lQtySetup."Value 5 Name" := FieldCaption("Default Qty Value 5");
        if lQtySetup."Value 6 Name" = '' then
            lQtySetup."Value 6 Name" := FieldCaption("Default Qty Value 6");
        if lQtySetup."Value 7 Name" = '' then
            lQtySetup."Value 7 Name" := FieldCaption("Default Qty Value 7");
        if lQtySetup."Value 8 Name" = '' then
            lQtySetup."Value 8 Name" := FieldCaption("Default Qty Value 8");
        if lQtySetup."Value 9 Name" = '' then
            lQtySetup."Value 9 Name" := FieldCaption("Default Qty Value 9");
        if lQtySetup."Value 10 Name" = '' then
            lQtySetup."Value 10 Name" := FieldCaption("Default Qty Value 10");

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

    procedure wGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lInvPostingGroup: Record "Inventory Posting Group";
    begin
        //+REF+CHARACTERISTIC
        if lInvPostingGroup.Get("Inventory Posting Group") then begin
            if lInvPostingGroup."Characteristic 1" = '' then
                lInvPostingGroup."Characteristic 1" := lInvPostingGroup.FieldCaption("Characteristic 1");
            if lInvPostingGroup."Characteristic 2" = '' then
                lInvPostingGroup."Characteristic 2" := lInvPostingGroup.FieldCaption("Characteristic 2");
            if lInvPostingGroup."Characteristic 3" = '' then
                lInvPostingGroup."Characteristic 3" := lInvPostingGroup.FieldCaption("Characteristic 3");
            case FieldNumber of
                1:
                    exit('8004051,' + lInvPostingGroup."Characteristic 1");
                2:
                    exit('8004051,' + lInvPostingGroup."Characteristic 2");
                3:
                    exit('8004051,' + lInvPostingGroup."Characteristic 3");
                4:
                    exit('8004051,' + lInvPostingGroup."Characteristic 4");
                5:
                    exit('8004051,' + lInvPostingGroup."Characteristic 5");
                6:
                    exit('8004051,' + lInvPostingGroup."Characteristic 6");
                7:
                    exit('8004051,' + lInvPostingGroup."Characteristic 7");
                8:
                    exit('8004051,' + lInvPostingGroup."Characteristic 8");
                9:
                    exit('8004051,' + lInvPostingGroup."Characteristic 9");
            end;
        end;
        //+REF+CHARACTERISTIC//
    end;

    procedure "// FNCT HJ DSFT"()
    begin
    end;

    procedure CheckFields()
    var
        TemplateMgt: Codeunit SoroubatFucntion;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        TemplateMgt.CheckMandatoriesFields(RecRef);
    end;

    procedure GetItemFilter(ParaFiltre: Code[20]) CdeItem: Code[20]
    var
        RecItem: Record Item;
        CdeArticle: Code[20];
    begin
        // >> HJ DSFT 02-02-2013
        RecItem.SetCurrentkey(Description);
        RecItem.SetFilter(Description, '*' + UpperCase(ParaFiltre) + '*');
        if page.RunModal(page::"Liste Article Filtré", RecItem) = Action::LookupOK then
            CdeArticle := RecItem."No.";
        exit(CdeArticle);

        // >> HJ DSFT 02-02-2013
    end;

    procedure CalculerCoutMateriaux()
    begin
        "Cout Materiaux" := Fourniture + Transport + ("% Perte" / 100) * (Fourniture + Transport);
        "Cout Sans Rendement" := Fourniture + Transport + ("% Perte" / 100) * (Fourniture + Transport);
        if Rendement <> 0 then "Cout Materiaux" := "Cout Sans Rendement" * Rendement;
        Perte := ("% Perte" / 100) * (Fourniture + Transport);
        "Unit Cost" := "Cout Materiaux";
    end;

    procedure "Vérifcara"(car: Text[1]; chaine: Text[100])
    var
        Poscar: Integer;
    begin
        //>> SAY 11-10-2018 Vérification Caractère
        Poscar := StrPos(chaine, car);
        if Poscar > 0 then Error(Text029);
        Message(Text030);
        //>> SAY 11-10-2018 Vérification Caractère
    end;




    var


        Text8003915: label 'Vous ne pouvez pas modifier %1 car il existe écritures sur l''article %2';

        PlanningAssignment: Record 99000850;
        BOMComp: Record "BOM Component";

        tNotLowerLevel: label 'You must select a low-level line';
        tStructureUsed: label 'You cannot delete %1 %2 because there is at least one structure component that includes this item.';
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        tGenericCostingMethod: label 'is not compatible with %1 %2';
        // "// Txt HJ DSFT": ;
        Text027: label 'Longueur Article Doit Etre egale à 13';
        "// RB SORO 13/05/2015": Integer;
        //GL2024  CuItemJnlPostLineEmpl: Codeunit 22;
        CuItemJnlPostLineEmpl: Codeunit "Item Jnl.-Post Line_CDU22";
        Text028: label 'Seuil Max Ne Peut Pas Etre Zero';
        Text029: label 'Vous avez saisie un caractère interdit.';
        Text030: label 'OK, Vous pouvez passer.';
        DimMgt: Codeunit DimensionManagementEvent;

}

