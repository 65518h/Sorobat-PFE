Table 50046 "Job Report Line"
{

    fields
    {
        field(1; Date; Date)
        {
            Caption = 'Date';
        }
        field(2; Job; Code[20])
        {
            Caption = 'Projet';
            TableRelation = Job;
        }
        field(3; "Job Assignment"; Code[20])
        {
            Caption = 'Affectation Marché';
            TableRelation = "Affectation Marche" where(Marche = field(Job));
        }
        field(4; Resource; Enum "Dys Rapport Chantier Resource")
        {
            Caption = 'Ressource';
            // OptionMembers = " ",Labor,Transport,Equipment,Supply,"Subcontractor";
        }
        field(5; Product; Code[20])
        {
            Caption = 'Article';
            TableRelation = Item;

            trigger OnValidate()
            begin
                if Item.Get(Product) then Description := Item.Description;
                Rec.CalcVarianceQty(Rec);
                /*  if Rec."Requirement Note No." <> '' then begin
                      RecInvShipLine.Reset();
                      RecInvShipLine.SetRange("Document No.", Rec."Requirement Note No.");
                      RecInvShipLine.SetRange("Item No.", Rec.Product);
                      if not RecInvShipLine.FindFirst() then
                          Error(TXT0001, Rec.Product, Rec."Requirement Note No.");
                  end;*/
            end;
        }
        field(6; Time; Time)
        {
            Caption = 'Heur';
        }
        field(7; Trip; Integer)
        {
            Caption = 'Voyage';
        }
        field(9; Origin; Text[20])
        {
            Caption = 'Origine';
            TableRelation = "Chargement - Dechargement";
        }
        field(10; Destination; Text[20])
        {
            Caption = 'Destination';
            TableRelation = "Chargement - Dechargement";
        }
        field(11; Equipment; Code[20])
        {
            Caption = 'Equipment';
            TableRelation = "Véhicule";

            trigger OnValidate()
            begin
                if Vehicle.Get(Equipment) then begin
                    Description := Vehicle."Désignation";
                    if Vehicle.Volume <> 0 then
                        Volume := Vehicle.Volume
                    else
                        Volume := 18;
                end;
            end;
        }
        field(12; Driver; Code[10])
        {
            Caption = 'Chauffeur';
            TableRelation = "Shipping Agent";
        }
        field(13; Labor; Code[20])
        {
            Caption = 'Matricule salarié';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if RecEmployee.Get(Labor) then begin
                    "Labor Description" := RecEmployee."FullName";
                end;

                // if RecEmployee.Get(Labor) then begin
                //     Assignment := RecEmployee.Assignment;
                //     Qualification := RecEmployee.Qualification;
                //     if RecSection.Get(RecEmployee.Assignment) then "Assignment Description" := RecSection.Description;
                //     if RecQualification.Get(RecEmployee.Qualification) then "Qualification Description" := RecQualification.Description;

                //     RecEmployee.CalcFields("Total Default Compensation");
                //     if RecEmployee."Hourly Base Salary" = 0 then
                //         "Gross Salary" := RecEmployee."Total Default Compensation" + RecEmployee."Basis salary"
                //     else
                //         "Gross Salary" := RecEmployee."Total Default Compensation" + RecEmployee."Hourly Base Salary";
                // end;

                if RecEmploymentContract.Get(Labor) then begin
                    "Labor Regime" := RecEmploymentContract."Regimes of work";
                    if RecWorkRegimes.Get(RecEmploymentContract."Regimes of work") then begin
                        "Hours per Month" := RecWorkRegimes."Work Hours per Month";
                        "Hourly Labor Cost" := "Gross Salary" / "Hours per Month";
                    end;
                end;

                if (Assignment = 'AD') or (Assignment = 'AD2') or (Assignment = 'AD3') then begin
                    "Hours per Month" := 0;
                    "Hourly Labor Cost" := 0;
                    "Gross Salary" := 0;
                end
            end;
        }
        field(14; "Start Time"; Time)
        {
            Caption = 'Heur début';
        }
        field(15; "End Time"; Time)
        {
            Caption = 'Heur Fin';
        }
        field(16; "Start Index"; Integer)
        {
            Caption = 'Index début';
        }
        field(17; "End Index"; Integer)
        {
            Caption = 'Index Fin';
        }
        field(18; "Breakdown Start Time"; Time)
        {
            Caption = 'Breakdown Start Time';
        }
        field(19; "Breakdown End Time"; Time)
        {
            Caption = 'Breakdown End Time';
        }
        field(20; "Occupation %"; Decimal)
        {
            Caption = 'Occupation %';
        }
        field(21; Location; Code[20])
        {
            Caption = 'Location';
            TableRelation = "Sous Affectation Marche" where("Marche" = field(Job));
        }
        field(22; Line; Integer)
        {
            Caption = 'Line';
            AutoIncrement = true;
        }
        field(23; Function; Code[50])
        {
            Caption = 'Function';
        }
        field(50001; "Sub Job Assignment"; Code[50])
        {
            Caption = 'Sub Job Assignment';
            TableRelation = "Sous Affectation Marche" where(Marche = field(Job));
        }
        field(50002; "Quantity Consumed"; Decimal)
        {
            Caption = 'Quantity Consumed';
        }
        field(50003; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(50004; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(50005; Observation; Text[250])
        {
            Caption = 'Observation';
        }
        field(50006; "Labor Description"; Text[100])
        {
            Caption = 'Labor Description';
            Editable = false;
        }
        field(50007; "Breakdown Counter"; Boolean)
        {
            Caption = 'Breakdown Counter';
        }
        field(50008; "Resource Count"; Integer)
        {
            Caption = 'Resource Count';
        }
        field(50009; "Hour Count"; Integer)
        {
            Caption = 'Hour Count';
        }
        field(50010; "Total M3"; Integer)
        {
            Caption = 'Total M3';
        }
        field(50011; "Total Hours"; Integer)
        {
            Caption = 'Total Heur';

            trigger OnValidate()
            begin
                "Line Cost" := "Hourly Labor Cost" * "Total Hours";
            end;
        }
        field(50012; "Distance Traveled"; Decimal)
        {
            Caption = 'Distance Traveled';
        }
        field(50013; "Equipment Description"; Text[100])
        {
            Caption = 'Equipment Description';
            CalcFormula = lookup("Véhicule"."Désignation" where("N° Vehicule" = field(Equipment)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50014; "Direct Cost"; Boolean)
        {
            Caption = 'Direct Cost';
        }
        field(50015; Cost; Decimal)
        {
            Caption = 'Cost';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(50017; Status; Enum "Dys Rapport Chantier Status")
        {
            Caption = 'Status';
            // OptionMembers = Open,"Validated";
        }
        field(50020; Volume; Decimal)
        {
            Caption = 'Volume';
        }
        field(50021; "Available Hours"; Decimal)
        {
            Caption = 'Available Hours';
        }
        field(50022; "Daily Cost"; Decimal)
        {
            Caption = 'Daily Cost';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(50023; "Stored Quantity on Site"; Decimal)
        {
            Caption = 'Stored Quantity on Site';
        }
        field(50024; "Labor Regime"; Code[10])
        {
            Caption = 'Labor Regime';
        }
        field(50025; "Hours per Month"; Decimal)
        {
            Caption = 'Hours per Month';
        }
        field(50026; Assignment; Code[10])
        {
            Caption = 'Assignment';
        }
        field(50027; Qualification; Code[10])
        {
            Caption = 'Qualification';
        }
        field(50028; "Assignment Description"; Text[100])
        {
            Caption = 'Assignment Description';
        }
        field(50029; "Qualification Description"; Text[100])
        {
            Caption = 'Qualification Description';
        }
        field(50030; "Hourly Labor Cost"; Decimal)
        {
            Caption = 'Hourly Labor Cost';
        }
        field(50031; "Gross Salary"; Decimal)
        {
            Caption = 'Gross Salary';
        }
        field(50032; Completion; Boolean)
        {
            Caption = 'Completion';
        }
        field(50033; "Task Description"; Text[250])
        {
            Caption = 'Task Description';
        }
        field(50034; "Line Cost"; Decimal)
        {
            Caption = 'Line Cost';
        }
        field(50035; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
        }
        field(50036; "Requirement Note No."; Text[30])
        {
            Caption = 'Requirement Note No.';
            TableRelation = "Invt. Shipment Line" where("DYSJob No." = field("Job No."));
            trigger OnLookup()
            var
                RecnvtShipmentHeader: Record "Invt. Shipment Header";
                PagePostedInvtShipments: Page "Posted Invt. Shipments";
                RecWipReportHeader: Record "WIP Report Header";
                Txt0002: Label 'There are no validated stock shipments on the project %1 on the date %2..%3 .';
            begin
                // if RecWipReportHeader.Get(Rec."WIP Report No.") then begin
                //     RecnvtShipmentHeader.Reset();
                //     RecnvtShipmentHeader.SetRange("DYSJob No.", Rec."Job No.");
                //     RecnvtShipmentHeader.SetRange("Posting Date", RecWipReportHeader."Starting date", RecWipReportHeader."Ending date");
                //     if not RecnvtShipmentHeader.FindSet() then begin
                //         Message(Txt0002, Rec."Job No.", RecWipReportHeader."Starting date", RecWipReportHeader."Ending date");
                //     end else
                //         if Page.RunModal(Page::"Posted Invt. Shipments", RecnvtShipmentHeader) = Action::LookupOK then
                //             Rec.Validate("Requirement Note No.", RecnvtShipmentHeader."No.");

                // end;

            end;

            trigger OnValidate()
            var

            begin
                if rec."Requirement Note No." <> '' then begin
                    RecInvShipLine.Reset();
                    RecInvShipLine.SetRange("Document No.", Rec."Requirement Note No.");
                    RecInvShipLine.SetRange("Item No.", Rec.Product);
                    if not RecInvShipLine.FindFirst() then
                        Error(TXT0001, Rec.Product, Rec."Requirement Note No.");
                    Rec.CalcVarianceQty(Rec);
                end;
            end;
        }
        field(50037; "Unit Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
                ResUnitofMeasure: Record "Resource Unit of Measure";
                lCurrFieldNo: Integer;
            begin
            end;
        }
        field(50038; "WIP Report No."; Code[20])
        {
            Caption = 'WIP Report No.';
        }
        field(50039; "Qty Gasoil"; Decimal)
        {
            Caption = 'Qty Gasoil';
        }
        field(60024; "Resource No."; Code[20])
        {
            Caption = 'Num Ressource';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."No." where("Equipment" = field("Equipment")));
        }
        field(60025; "Job No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            Caption = 'N° Projet';
        }
        field(60026; "Job Task No."; Code[20])
        {
            Caption = 'N° Tâche Projet';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));


        }
        field(60027; "Job Planning Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'N° Ligne Planning Projet';
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("Job No."),
            "Job Task No." = field("Job Task No."));
            trigger OnValidate()
            var
                RecWipReportLine: Record "WIP Report Line";
            begin
                Rec.CalcVarianceQty(Rec);
                // Rec.CalcFields("Quantity issued from store");
                // RecWipReportLine.Reset();
                // RecWipReportLine.SetRange("WIP Report No.", Rec."WIP Report No.");
                // RecWipReportLine.SetRange("DysJob Planning Line No.", Rec."Job Planning Line No.");
                // if RecWipReportLine.FindFirst() then begin
                //     Rec.CalcFields("Theoretical Unit Consumed Qty");
                //     Rec."Theoretical Consumed Quantity" := "Theoretical Unit Consumed Qty" * RecWipReportLine.Quantity;
                // end else
                //     Rec."Theoretical Consumed Quantity" := 0;
                // Rec."quantity variance" := Rec."Theoretical Consumed Quantity" - "Quantity issued from store";

            end;
        }
        field(60028; "Quantity issued from store"; Decimal)
        {
            Caption = 'Quantity issued from store';
            //  DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup("Invt. Shipment Line".Quantity where("Document No." = field("Requirement Note No."),
            "Item No." = field(Product), "DYSJob No." = field("Job No.")));
            Editable = false;
        }
        field(60029; "Theoretical Consumed Quantity"; Decimal)
        {
            Caption = 'Theoretical Consumed Quantity';
        }
        field(60030; "Theoretical Unit Consumed Qty"; Decimal)
        {
            Caption = 'Theoretical Unit Consumed Quantity';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Job Component"."Quantity per" where("No." = field(Product),
            "Job No." = field("Job No."),
            "Job Task No." = field("Job Task No.")));

        }
        field(60031; "quantity variance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Document No.", Line, "WIP Report No.")
        {
            Clustered = true;
        }
        key(Key2; Date, Job, Equipment)
        {
        }
        key(Key3; Date, Job, Product)
        {
        }
        key(Key4; Date, Job, Labor)
        {
        }
    }

    fieldgroups
    {
    }
    procedure CalcVarianceQty(var RecObReportLine: Record "Job Report Line")
    var
        RecWipReportLine: Record "WIP Report Line";
        deded: Report 1001;
    begin
        RecObReportLine."quantity variance" := 0;
        RecObReportLine."Theoretical Consumed Quantity" := 0;
        RecObReportLine.CalcFields("Quantity issued from store");
        RecWipReportLine.Reset();
        RecWipReportLine.SetRange("WIP Report No.", RecObReportLine."WIP Report No.");
        RecWipReportLine.SetRange("DysJob Planning Line No.", RecObReportLine."Job Planning Line No.");
        if RecWipReportLine.FindFirst() then begin
            RecObReportLine.CalcFields("Theoretical Unit Consumed Qty");
            RecObReportLine."Theoretical Consumed Quantity" := "Theoretical Unit Consumed Qty" * RecWipReportLine.Quantity;
        end else
            RecObReportLine."Theoretical Consumed Quantity" := 0;
        RecObReportLine."quantity variance" := RecObReportLine."Theoretical Consumed Quantity" - "Quantity issued from store";
    end;

    trigger OnModify()
    var
    begin
        Rec.CalcVarianceQty(Rec);

    end;

    trigger OnInsert()
    var
        WipReportHeader: Record "WIP Report Header";
    begin
        if WipReportHeader.Get(Rec."WIP Report No.") then begin
            Rec."Job No." := WipReportHeader."Job No.";
            if WipReportHeader."Job Task No." <> '' then
                Rec."Job Task No." := WipReportHeader."Job Task No.";
        end;
        if JobReportHeader.Get("Document No.") then begin
            Date := JobReportHeader.Journee;
            Job := JobReportHeader.Marche;
            "Job Assignment" := JobReportHeader.Article;
            "Sub Job Assignment" := JobReportHeader."Sous Article";
        end;
    end;

    var
        Vehicle: Record "Véhicule";
        Resource: Record Resource;
        Item: Record Item;
        JobReportHeader: Record 52049027;
        Text001: label 'Qualification not mentioned for this resource, please fill in this field';
        RecEmployee: Record Employee;
        RecEmploymentContract: Record "Employment Contract";
        RecWorkRegimes: Record "Regimes of work";
        //  RecSection: Record 50112;
        RecQualification: Record Qualification;
        RecInvShipLine: Record "invt. Shipment Line";
        TXT0001: Label 'Item %1 does not exist Under the requirement No %2';
}

