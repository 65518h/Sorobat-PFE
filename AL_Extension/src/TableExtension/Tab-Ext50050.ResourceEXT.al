TableExtension 50050 ResourceEXT extends Resource
{
    fields
    {
        modify(Type)
        {
            Description = 'Modification Caption FRA';

        }
        modify("Resource Group No.")
        {
            TableRelation = "Resource Group" where(Type = field(Type));

            trigger OnBeforeValidate()
            VAR
                lResGr: Record "Resource / Resource Group";
                lReplicationRef: RecordRef;
            begin

                //PLANNING
                IF NOT lResGr.GET("No.", "Resource Group No.") AND ("Resource Group No." <> '') THEN BEGIN
                    lResGr."Resource No." := "No.";
                    lResGr."Resource Group No." := "Resource Group No.";
                    lResGr.INSERT;
                END;
                //PLANNING//
            end;

            trigger OnAfterValidate()
            VAR
                lResGr: Record "Resource / Resource Group";
                lReplicationRef: RecordRef;
            begin
                //REPLIC
                lReplicationRef.GETTABLE(xRec);
                wReplicationRef.GETTABLE(Rec);
                wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
                //REPLIC//
            end;
        }

        modify("Base Unit of Measure")
        {
            //GL2024    ValidateTableRelation =false;
            trigger OnBeforeValidate()
            var

                UnitOfMeasure: Record "Unit of Measure";
                lSubcontractingMgt: Codeunit "Subcontracting Management";

            begin
                if "Base Unit of Measure" <> xRec."Base Unit of Measure" then begin
                    //SUBCONTRACTOR
                    lSubcontractingMgt.ItemUnitOfMeasure("No.", '', "Base Unit of Measure");
                    //SUBCONTRACTOR//


                end;
            end;



        }



        /*  GL2024 License  modify("Unit Price")
            {
                //blankzero = true;
            }*/
        modify("Qty. on Order (Job)")
        {
            Caption = 'Qty. on Order (Job)';

            Description = 'Modification CalcFormula sur Total Quantity';
        }
        modify("Qty. Quoted (Job)")
        {
            Caption = 'Qty. Quoted (Job)';

            Description = 'Modification CalcFormula sur Total Quantity';
        }
        modify("Usage (Qty.)")
        {
            Description = 'Modification CalcFormula';
            ;
        }


        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }

        field(50101; Equipment; Code[20])
        {
            Caption = 'Equipment';
            TableRelation = "Véhicule";
            trigger OnValidate()
            begin
                /*  if (Rec.Equipment <> '') and (Rec.Type <> Rec.Type::Machine) then
                      Rec.Type := Rec.Type::Machine;*/
            end;
        }
        field(50000; Section; Code[20])
        {
            Description = 'HJ DSFT 20-06-2012';
            TableRelation = "Standard Text";
        }
        field(50001; "Type Index"; Option)
        {
            Description = 'HJ DSFT 26-03-2012';
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(50002; "Intégrer"; Boolean)
        {
            Description = 'HJ DSFT 20-06-2012';
        }
        field(50003; "Code Etude"; Code[10])
        {
            Description = 'HJ DSFT 20-06-2012';
        }
        field(50004; Ordre; Code[10])
        {
            Description = 'HJ SORO 17-07-2014';
        }
        field(50005; Parent; Code[20])
        {
            Description = 'HJ SORO 17-07-2014';
        }
        field(50006; Compteur; Integer)
        {
        }
        field(50007; "Code BB"; Code[20])
        {
            Description = 'HJ SORO 08-08-2014 ---  BB=Bareme Bleu';
            // TableRelation = "Bareme Bleu";

            /*  trigger OnValidate()
              begin
                  // >> HJ SORO 08-08-2014
                  if BaremeBleu.Get("Code BB") then begin
                      Validate("IM Cout Direct", BaremeBleu.IM);
                      Validate("UM Cout Direct", BaremeBleu.UM);
                      Validate("Cout Consommation Direct", BaremeBleu.Consommation);
                      Validate("Lubrifiant Pt Entre Cout Direc", BaremeBleu.Lubrifiant);
                  end;
                  // >> HJ SORO 08-08-2014
              end;*/
        }
        field(50008; "IM Cout Direct"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Immobilisation Materiel Recupere Du BB (Breme Bleu)';

            trigger OnValidate()
            begin
                Validate(IM, "IM Cout Direct");
                CalculerCoutMateriel;
            end;
        }
        field(50009; "UM Cout Direct"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Utilisation Materiel Recupere Du BB (Breme Bleu)';

            trigger OnValidate()
            begin
                Validate(UM, "UM Cout Direct");
                CalculerCoutMateriel;
            end;
        }
        field(50010; "Cout Consommation Direct"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Consommation Materiel Recupere Du BB (Breme Bleu)';

            trigger OnValidate()
            begin
                "Cout Consommation" := "Cout Consommation Direct";
                CalculerCoutMateriel;
            end;
        }
        field(50011; "MO Conducteur Engin"; Boolean)
        {
            Description = 'HJ SORO 08-08-2014 ---- Si Materielle Avec Conducteur';
        }
        field(50012; Conducteur; Code[20])
        {
            Description = 'HJ SORO 08-08-2014 ----Code Conducteur Lié Au Materielle';
            TableRelation = if (Type = const(Machine)) Resource."No." where("MO Conducteur Engin" = const(true),
                                                                           Type = const(Person));

            trigger OnValidate()
            begin
                if Res.Get(Conducteur) then "Cout MO Materielle" := Res."Unit Cost";
            end;
        }
        field(50013; "Cout MO Materielle Direct"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Cout Conducteur Lié Au Materielle';

            trigger OnValidate()
            begin
                "Cout MO Materielle" := "Cout MO Materielle Direct";
                CalculerCoutMateriel;
            end;
        }
        field(50014; "Lubrifiant Pt Entre Cout Direc"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Consommation Materiel Recupere Du BB (Breme Bleu)';

            trigger OnValidate()
            begin
                Validate("Lubrifiant Petit Entretient", "Lubrifiant Pt Entre Cout Direc");
                CalculerCoutMateriel;
            end;
        }
        field(50015; Marche; Code[20])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = Job;
        }
        field(50016; "Cout MO Materielle"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Cout Conducteur Lié Au Materielle';
        }
        field(50017; IM; Decimal)
        {
            Description = 'HJ SORO 08-08-2014 ---- Immobilisation Materiel Recupere Du BB (Breme Bleu)';
        }
        field(50018; UM; Decimal)
        {
            Description = 'HJ SORO 08-08-2014 ---- Utilisation Materiel Recupere Du BB (Breme Bleu)';
        }
        field(50019; "Lubrifiant Petit Entretient"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Consommation Materiel Recupere Du BB (Breme Bleu)';

            trigger OnValidate()
            begin
                CalculerCoutMateriel;
            end;
        }
        field(50020; "Cout De Base"; Decimal)
        {
        }
        field(50021; "Cout Consommation"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 08-08-2014 ---- Consommation Materiel Recupere Du BB (Breme Bleu)';
        }
        field(50099; Qualification; Code[20])
        {
            Description = 'HJ SORO 03/06/2017';
            TableRelation = Qualification;
        }
        field(50100; "N° Immobilisation"; Code[20])
        {
            Caption = 'N° Immobilisation';
            Description = 'BSK IMMOBILISATION =Materiel';
            TableRelation = "Fixed Asset"."No.";
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8001905; "Review Option"; Option)
        {
            Caption = 'Review Option';
            OptionCaption = ' ,Formula';
            OptionMembers = " ",Formula;
        }
        field(8002000; "Note of Expenses Account"; Code[20])
        {
            Caption = 'Note of Expenses Account';
            TableRelation = "G/L Account";
        }
        field(8003900; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job where("Search Description" = filter('*'));
        }
        field(8003901; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8003902; "Working Time"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Journal Line"."Quantity (Base)" where(Type = const(Resource),
                                                                          "No." = field("No."),
                                                                          "Job No." = field("Job No. Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Work Type Code" = field("Work Type Filter"),
                                                                          "Journal Template Name" = field("Journal Template Name Filter"),
                                                                          "Journal Batch Name" = field("Journal Batch Name Filter")));
            Caption = 'Working Time';
            FieldClass = FlowField;
        }
        field(8003903; "Job No. Filter"; Code[20])
        {
            Caption = 'Job No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Job;
        }
        field(8003907; "Work Type Filter"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "Work Type";
        }
        field(8003908; "Journal Template Name Filter"; Code[10])
        {
            Caption = 'Journal Template Name';
            FieldClass = FlowFilter;
            TableRelation = "Job Journal Template";
        }
        field(8003909; "Journal Batch Name Filter"; Code[10])
        {
            Caption = 'Journal Batch Name';
            FieldClass = FlowFilter;
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Journal Template Name Filter"));
        }
        field(8003910; "Travel Code"; Code[10])
        {
            Caption = 'Travel Code';
            TableRelation = "Travel Code";
        }
        field(8003911; "User ID"; Code[20])
        {
            Caption = 'User ID';
            //GL2024 TableRelation = Login;

            trigger OnValidate()
            var
                lRec: Record Resource;
                ltExists: label 'already assigned';
            begin
                if "User ID" <> '' then begin
                    lRec.SetCurrentkey("User ID");
                    lRec.SetRange("User ID", "User ID");
                    lRec.SetFilter("No.", '<>%1', "No.");
                    if lRec.FindFirst then
                        lRec.FieldError("User ID", ltExists);
                end;
            end;
        }
        field(8003912; "WT Allowed"; Boolean)
        {
            Caption = 'Working Time Allowed';
        }
        field(8003929; "Tree Code"; Text[20])
        {
            Caption = 'Tree Code';
            TableRelation = Tree.Code where(Type = field(Type));

            trigger OnLookup()
            var
                lPyramid: Record Tree;
            begin
                case Type of
                    Type::Person:
                        lPyramid.SetRange(Type, lPyramid.Type::Person);
                    Type::Machine:
                        lPyramid.SetRange(Type, lPyramid.Type::Machine);
                    Type::Structure:
                        lPyramid.SetRange(Type, lPyramid.Type::Structure);
                    else
                        ;
                end;
                lPyramid.SetFilter(Code, "Tree Code");
                if lPyramid.Find('-') then;
                lPyramid.SetRange(Code);
                case Type of
                    Type::Person:
                        begin
                            Type := lPyramid.Type::Person;
                            "Tree Code" := lPyramid.LookUpForm(0, "Tree Code");
                        end;
                    Type::Machine:
                        begin
                            Type := lPyramid.Type::Machine;
                            "Tree Code" := lPyramid.LookUpForm(1, "Tree Code");
                        end;
                    Type::Structure:
                        begin
                            Type := lPyramid.Type::Structure;
                            "Tree Code" := lPyramid.LookUpForm(2, "Tree Code");
                        end;
                    else
                        ;
                end;
            end;

            trigger OnValidate()
            var
                lPyramid: Record Tree;
            begin
                case Type of
                    Type::Person:
                        lPyramid.OnValidate(lPyramid.Type::Person, "Tree Code");
                    Type::Machine:
                        lPyramid.OnValidate(lPyramid.Type::Machine, "Tree Code");
                    Type::Structure:
                        lPyramid.OnValidate(lPyramid.Type::Structure, "Tree Code");
                    else
                        ;
                end;
            end;
        }
        field(8003941; "Resource Disc. Group"; Code[10])
        {
            Caption = 'Resource Disc. Group';
            TableRelation = "Resource Discount Group";
        }
        field(8003943; "Starting Date Filter"; Date)
        {
            Caption = 'Starting Date Filter';
            FieldClass = FlowFilter;
        }
        field(8003944; "Ending Date Filter"; Date)
        {
            Caption = 'Ending Date Filter';
            FieldClass = FlowFilter;
        }
        field(8003945; "In Mission"; Boolean)
        {
            CalcFormula = exist("Interim Mission" where("Resource No." = field("No."),
                                                         "Starting Date" = field("Starting Date Filter"),
                                                         "Ending Date" = field("Ending Date Filter")));
            Caption = 'In Mission';
            FieldClass = FlowField;
        }
        field(8003946; "In Res. Group"; Boolean)
        {
            CalcFormula = exist("Resource / Resource Group" where("Resource Group No." = field("Res. Group Filter"),
                                                                   "Resource No." = field("No.")));
            Caption = 'In Resource Group';
            FieldClass = FlowField;
        }
        field(8003947; "Res. Group Filter"; Code[20])
        {
            Caption = 'Res. Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(8003948; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Internal,External,Generic';
            OptionMembers = Internal,External,Generic;
        }
        field(8003949; "Responsible No."; Code[20])
        {
            Caption = 'Responsible No.';
            TableRelation = Resource where(Type = const(Person));
        }
        field(8003950; Rate; Decimal)
        {
            //blankzero = true;
            Caption = 'Rate';

            trigger OnValidate()
            var
                lDetailStructure: Record "Structure Component";
            begin
                //CADENCE
                if xRec.Rate = 0 then
                    xRec.Rate := 1;
                lDetailStructure.SetRange("Parent Structure No.", "No.");
                lDetailStructure.SetFilter(Type, '%1|%2', lDetailStructure.Type::Person, lDetailStructure.Type::Machine);
                if lDetailStructure.Find('-') then
                    repeat
                        if Rate <> 0 then begin
                            if lDetailStructure."Rate Quantity" <> 0 then
                                lDetailStructure."Quantity per" := lDetailStructure."Rate Quantity" / Rate
                            else
                                if lDetailStructure."Quantity per" <> 0 then
                                    lDetailStructure."Rate Quantity" := lDetailStructure."Quantity per" * Rate;
                        end;

                        lDetailStructure.Modify;
                    until lDetailStructure.Next = 0;
                //CADENCE//
            end;
        }
        field(8003951; "Unit price Calculated"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Unit price Calculated';
            MinValue = 0;
        }
        field(8003952; "Default Rate Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Default Rate Quantity';
        }
        field(8003953; "Default Number of Resources"; Integer)
        {
            Caption = 'Default Number Of Resources';
            InitValue = 1;
        }
        field(8003954; "Value Option"; Option)
        {
            Caption = 'Mode de calcul';
            OptionCaption = 'Amount,% on Base,% on Result';
            OptionMembers = Amount,"% on Base","% on Result";
        }
        field(8003955; "Rate Amount"; Decimal)
        {
            Caption = 'Rate or Amount';
            Description = 'Taux ou montant de frais ou de remise en fonction du mode de calcul sélectionné';
        }
        field(8003956; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where(Type = field(Type),
                                                               "No." = field("No."),
                                                               Date = field("Date Filter"),
                                                               "Job No." = field("Job No. Filter"),
                                                               Private = const(false),
                                                               "Prod. Posting Group" = field("Prod. Posting Group Filter"),
                                                               Status = filter(<> Deleted)));
            Caption = 'Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004131; "Period Planning Task Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where(Type = field(Type),
                                                               "No." = field(filter("No.")),
                                                               Date = field("Date Filter"),
                                                               Private = const(false),
                                                               "Planning Task No." = field("Task No. Filter")));
            Caption = 'Planning Task Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004132; "Prod. Posting Group Filter"; Code[10])
        {
            Caption = 'Prod. Posting Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group" where("Resource Type" = filter(<> " "));
        }
        field(8004150; Subcontracting; Option)
        {
            Caption = 'Subcontracting';
            OptionCaption = ' ,Furniture and Fixing,Fixing';
            OptionMembers = " ","Furniture and Fixing",Fixing;

            trigger OnValidate()
            var
                lSubcontractingMgt: Codeunit "Subcontracting Management";
            begin
                //SUBCONTRACTOR
                lSubcontractingMgt.CheckStructure(Rec);
                //SUBCONTRACTOR//
            end;
        }
        field(8004153; "Assignment Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionCaption = ' ,All';
            OptionMembers = " ",All;

            trigger OnValidate()
            var
                lTextNoAssgnt: label 'You must enter a %1.';
                lTextError: label 'You cannot enter %1 on a text line.';
            begin
            end;
        }
        field(8004154; "Assignment Basis"; Option)
        {
            Caption = 'Job Cost Assignment Basis';
            OptionCaption = ' ,Person Quantity,Direct Cost,Cost Price,Estimated Price,Specific';
            OptionMembers = " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;
        }
        field(8004155; "Producted Hours"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Quantity (Base)" where("No." = field("No."),
                                                                          Type = filter(Resource),
                                                                          "Entry Type" = filter(Usage),
                                                                          "Work Time Type" = filter("Producted Hours"),
                                                                          "Job No." = field("Job No. Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Work Type Code" = field("Work Type Filter")));
            Caption = 'Producted Hours';
            FieldClass = FlowField;
        }
        field(8004156; "Unproducted Hours"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Quantity (Base)" where("No." = field("No."),
                                                                          Type = filter(Resource),
                                                                          "Entry Type" = filter(Usage),
                                                                          "Work Time Type" = filter("Unproduced Hours"),
                                                                          "Job No." = field("Job No. Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Work Type Code" = field("Work Type Filter")));
            Caption = 'Unproducted Hours';
            FieldClass = FlowField;
        }
        field(8004157; "Absence Hours"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Quantity (Base)" where("No." = field("No."),
                                                                          Type = filter(Resource),
                                                                          "Entry Type" = filter(Usage),
                                                                          "Work Time Type" = filter("Absence Hours"),
                                                                          "Job No." = field("Job No. Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Work Type Code" = field("Work Type Filter")));
            Caption = 'Absence Hours';
            FieldClass = FlowField;
        }
        field(8004158; "Total Cost (hours)"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("No." = field("No."),
                                                                           Type = filter(Resource),
                                                                           "Entry Type" = filter(Usage),
                                                                           "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours"),
                                                                           "Job No." = field("Job No. Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Work Type Code" = field("Work Type Filter")));
            Caption = 'Total Cost (Hours)';
            FieldClass = FlowField;
        }
        field(8004159; Premium; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("No." = field("No."),
                                                                           Type = filter(Resource),
                                                                           "Entry Type" = filter(Usage),
                                                                           "Work Time Type" = filter(Premium),
                                                                           "Job No." = field("Job No. Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Work Type Code" = field("Work Type Filter")));
            Caption = 'Total Cost (Hours)';
            FieldClass = FlowField;
        }
        field(8004160; Transport; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("No." = field("No."),
                                                                           Type = filter(Resource),
                                                                           "Entry Type" = filter(Usage),
                                                                           "Work Time Type" = filter(Transport),
                                                                           "Job No." = field("Job No. Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Work Type Code" = field("Work Type Filter")));
            Caption = 'Transport';
            FieldClass = FlowField;
        }
        field(8004161; Meal; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("No." = field("No."),
                                                                           Type = filter(Resource),
                                                                           "Entry Type" = filter(Usage),
                                                                           "Work Time Type" = filter(Meal),
                                                                           "Job No." = field("Job No. Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Work Type Code" = field("Work Type Filter")));
            Caption = 'Meal';
            FieldClass = FlowField;
        }
        field(8004162; "Job. Posted Quantity (Base)"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Quantity (Base)" where("No." = field("No."),
                                                                          Type = const(Resource),
                                                                          "Entry Type" = const(Usage),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours"),
                                                                          "Job No." = field("Job No. Filter"),
                                                                          "Work Type Code" = field("Work Type Filter")));
            Caption = 'Posted Quantity (Base)';
            FieldClass = FlowField;
        }
        field(8004163; "Total Cost"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Total Cost (LCY)" where("No." = field("No."),
                                                                           Type = filter(Resource),
                                                                           "Entry Type" = filter(Usage),
                                                                           "Work Time Type" = filter("Producted Hours" | "Unproduced Hours" | "Absence Hours" | Premium | Transport | Meal),
                                                                           "Job No." = field("Job No. Filter"),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Work Type Code" = field("Work Type Filter")));
            Caption = 'Total Cost (Hours)';
            FieldClass = FlowField;
        }
        field(8004164; "Job Usage (Qty)"; Decimal)
        {
            CalcFormula = sum("Job Ledger Entry"."Quantity (Base)" where("No." = field("No."),
                                                                          Type = filter(Resource),
                                                                          "Entry Type" = filter(Usage),
                                                                          "Job No." = field("Job No. Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Work Type Code" = field("Work Type Filter"),
                                                                          "Bal. Created Entry" = const(false)));
            Caption = 'Job Usage (Qty)';
            FieldClass = FlowField;
        }
        field(8004165; "Weekly Schedule Code"; Code[10])
        {
            Caption = 'Weekly Schedule Code';
            TableRelation = "Weekly Schedule Template";
        }
        field(8004166; "Res. Posted Quantity (Base)"; Decimal)
        {
            CalcFormula = sum("Res. Ledger Entry"."Quantity (Base)" where("Entry Type" = const(Usage),
                                                                           Chargeable = field("Chargeable Filter"),
                                                                           "Unit of Measure Code" = field("Unit of Measure Filter"),
                                                                           "Resource No." = field("No."),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Planning Source" = const(true)));
            Caption = 'Posted Planning Quantity (Base)';
            FieldClass = FlowField;
        }
        field(8035003; "Task No. Filter"; Text[20])
        {
            Caption = 'Task No. Filter';
            FieldClass = FlowFilter;
        }
        field(8035004; Imposed; Boolean)
        {
            CalcFormula = exist("Planning Task Assignment" where("Task No." = field("Task No. Filter"),
                                                                  "No." = field("No."),
                                                                  Type = const(Resource)));
            Caption = 'Imposed';
            FieldClass = FlowField;
        }
        field(8035005; "In Skill"; Boolean)
        {
            CalcFormula = exist("Resource / Planning Skill" where("Skill Code" = field("Skill Group Filter")));
            Caption = 'In Skill';
            FieldClass = FlowField;
        }
        field(8035009; "Skill Group Filter"; Code[20])
        {
            Caption = 'Skill Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
    }
    keys
    {

        /* GL2024   key(Key10; Type, "Bal. Job No.", "No.")
            {
            }
    */
        key(Key11; "Resource Group No.", "Search Name", "No.")
        {
        }

        /* GL2024   key(Key12; Type, "WT Allowed", Status, "No.")
            {
                MaintainSQLIndex = false;
            }*/
        key(Key13; "WT Allowed")
        {
        }
        key(Key14; "Tree Code")
        {
        }
        key(Key15; "User ID")
        {
            MaintainSIFTIndex = false;
        }
        key(Key16; Compteur)
        {
        }
    }





    trigger OnAfterModify()
    var
        lReplicationRef: RecordRef;
        lEmployee: Record Employee;
        lEmployeeResUpdate: Codeunit "Employee/Resource Update";
    begin
        //RESSOURCE
        //IF lEmployee.READPERMISSION AND (Type = Type::Person) AND (Status = Status::Internal) THEN
        //  lEmployeeResUpdate.wResToHumanRes(xRec,Rec);
        //RESSOURCE//
        //REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //REPLIC//

    end;

    trigger OnBeforeDelete()
    VAR
        lStructComp: Record "Structure Component";
        lDescLine: Record "Description Line";
        lResUnitOfMeasure: Record "Resource Unit of Measure";
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //OUVRAGE
        lStructComp.SETCURRENTKEY(Type);
        CASE Type OF
            Type::Person:
                lStructComp.SETRANGE(Type, lStructComp.Type::Person);
            Type::Machine:
                lStructComp.SETRANGE(Type, lStructComp.Type::Machine);
            Type::Structure:
                lStructComp.SETRANGE(Type, lStructComp.Type::Structure);
            ELSE
                ;
        END;
        lStructComp.SETRANGE("No.", "No.");
        IF NOT lStructComp.ISEMPTY THEN
            IF lStructComp.FIND('-') THEN
                ERROR(ErrorOuv, Type, "No.", lStructComp."Parent Structure No.");
        //OUVRAGE//

        //#6115
        IF Type = Type::Structure THEN BEGIN
            lRecRef.GETTABLE(Rec);
            lBOQCustMgt.gOndelete(lRecRef, TRUE);
        END;
        //#6115//


        //RESSOURCE
        lStructComp.RESET;
        lStructComp.SETRANGE("Parent Structure No.", "No.");
        IF lStructComp.FIND('-') THEN
            lStructComp.DELETEALL;
        lDescLine.SETRANGE("Table ID", DATABASE::Resource);
        lDescLine.SETRANGE("Document Type", 0);
        lDescLine.SETRANGE("Document No.", "No.");
        IF lDescLine.FIND('-') THEN
            lDescLine.DELETEALL;
        //RESSOURCE//

    end;

    trigger OnAfterDelete()
    var
        lResUnitOfMeasure: Record "Resource Unit of Measure";
    begin

        //+REF+UNIT
        lResUnitOfMeasure.SETRANGE("Resource No.", "No.");
        lResUnitOfMeasure.DELETEALL;
        //+REF+UNIT//
        //REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //REPLIC//
    end;



    trigger OnAfterRename()
    VAR
        lReplicationRef: RecordRef;
        lRecRef: RecordRef;
        lxRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin

        //#6889
        lRecRef.GETTABLE(Rec);
        lxRecRef.GETTABLE(xRec);
        //#6902
        lBOQCustMgt.gOnRenameWithChild(lRecRef, lxRecRef);
        // Maintenant c'est bien gentil tous ‡a, mais il faut supprimer le document orphelin sur l'ancienne cl‚
        IF xRec.Type = xRec.Type::Structure THEN BEGIN
            lRecRef.GETTABLE(xRec);
            lBOQCustMgt.gOndelete(lRecRef, TRUE);
        END;
        //#6115//

        //#6902//
        //#6889//
        //REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //REPLIC//

    end;



    procedure gCheckResGrp(pResNo: Code[20]; pResGpNo: Code[20]; pStopOnError: Boolean) Return: Boolean
    var
        lResGrp: Record "Resource / Resource Group";
        tError: label 'The Group Resource "%1" is not assigning to the Resource "%2".';
    begin
        /*<FunctionName Name="gCheckResGrp">
          <Data-Flow>
            <InPut Name="pRes" Type="Code20">"N° ressource" vérifié</InPut>
            <InPut Name="pResGpNo" Type="Code20">"N° groupe de ressource" testé</InPut>
            <InPut Name="pStopOnError" Type="Boolean">Si true la function déclenche une erreur</InPut>
            <OutPut Name="Return" Type="Boolean">Si faux le paramétrage est incorrecte<OutPut>
          <OutPut>
          <Data-Flow>
          <Summary>
            Vérifie le paramétrage du groupe de ressource dans une ressource
          </Summary>
        </FunctionName>*/

        lResGrp.SetRange("Resource No.", pResNo);
        lResGrp.SetRange("Resource Group No.", pResGpNo);
        Return := lResGrp.IsEmpty;
        if pStopOnError and Return then
            Error(tError, pResGpNo, pResNo);

    end;

    procedure "//Hj"()
    begin
    end;

    procedure CalculerCoutMateriel()
    begin
        // >> HJ SORO 24-08-2014
        Validate("Cout De Base", "IM Cout Direct" + "UM Cout Direct" + "Lubrifiant Pt Entre Cout Direc");
        Validate("Unit Cost", "IM Cout Direct" + "UM Cout Direct" + "Lubrifiant Pt Entre Cout Direc" + "Cout Consommation Direct" +
        "Cout MO Materielle Direct");
        // >> HJ SORO 24-08-2014
    end;


    var
        //ResCost : Record 202;
        ResCost: Record "Resource Cost";

        //PlanningLine :Record 1003;
        PlanningLine: Record "Job Planning Line";
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        tNotLowerLevel: label 'You must select a low-level line';
        ErrorOuv: label 'You can''t delete %1 %2, because it''s used in structure .';
        "// HJ SORO": Integer;
        // BaremeBleu: Record "Bareme Bleu";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Res: Record Resource;
}

