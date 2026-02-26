table 52048921 "FOR-Formations"
{
    //GL2024  ID dans Nav 2009 : "39001470"
    Caption = 'Alternative Address';
    DataCaptionFields = "Employee No.", Name;
    // DrillDownPageID = "FOR-Liste Demandes Formations";
    // LookupPageID = "FOR-Liste Demandes Formations";



    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                CALCFIELDS(Name, Prenom, "Job Title");
                Employee.RESET;
                IF Employee.GET("Employee No.") THEN BEGIN
                    Prenom := Employee."Last Name";
                    Name := Employee."First Name";

                    Direction := Employee.Direction;
                    Service := Employee.Service;
                    section := Employee.Section;
                    Employee.CALCFIELDS("Job Title");
                    "Job Title" := "Job Title";
                END;
            end;
        }
        field(2; "Begining Date"; Date)
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Ending Date" := CALCDATE(FORMAT("Day number") + 'J', "Begining Date");
                "Posting date" := "Begining Date";
            end;
        }
        field(3; Name; Text[30])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Name';
            FieldClass = FlowField;
        }
        field(4; Prenom; Text[30])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Name 2';
            FieldClass = FlowField;
        }
        field(5; Description; Text[30])
        {
            Caption = 'Address';
        }
        field(6; Address; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //GL2024     PostCode.LookUpCity(City, "Post Code","Country Code",'', TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024     PostCode.ValidateCity(City, "Post Code");
            end;
        }
        field(8; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //GL2024    PostCode.LookUpPostCode(City, "Post Code", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024    PostCode.ValidatePostCode(City, "Post Code");
            end;
        }
        field(9; County; Text[30])
        {
            Caption = 'County';
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Phone No.';
        }
        field(11; "Ending Date"; Date)
        {
            Caption = 'Fax No.';
            Editable = false;
        }
        field(12; "Day number"; Decimal)
        {
            Caption = 'E-Mail';

            trigger OnValidate()
            begin
                "Ending Date" := CALCDATE(FORMAT("Day number") + 'J', "Begining Date");
                "Posting date" := "Begining Date";
            end;
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(15; "Training center"; Code[20])
        {
            Caption = 'Centre formation';
            TableRelation = "FOR-Centres Formations".Code;

            trigger OnValidate()
            begin
                RecGCentreFormation.RESET;
                IF RecGCentreFormation.GET("Training center") THEN BEGIN
                    Description := RecGCentreFormation.Description;
                    Address := RecGCentreFormation.Address;
                    City := RecGCentreFormation.City;
                    "Post Code" := RecGCentreFormation."Post Code";
                    County := RecGCentreFormation.County;
                END;
            end;
        }
        field(16; "Posting date"; Date)
        {
            Caption = 'date comptabilisation';
        }
        field(17; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External';
            OptionMembers = ,Internal,External;
        }
        field(18; Topic; Code[20])
        {
            Caption = 'Thème';
            TableRelation = "FOR-Themes Formations"."Topic Code" WHERE(Code = FIELD("Training center"));

            trigger OnValidate()
            begin
                RecGThemes.RESET;
                IF RecGThemes.GET("Training center", Topic) THEN BEGIN
                    "Topic description" := RecGThemes.Description;
                    "Day number" := RecGThemes."Day number";
                    Amount := RecGThemes.Cost;
                END;
            end;
        }
        field(19; "Topic description"; Text[100])
        {
            Caption = 'Désignation thème';
        }
        field(20; "Training No."; Integer)
        {
            Caption = 'N° Formation';
        }
        field(21; "Job Title"; Text[30])
        {
            CalcFormula = Max("Employee Qualification".Description WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Fonction';
            FieldClass = FlowField;
        }
        field(22; Direction; Code[10])
        {
            TableRelation = Direction.Code;
        }
        field(23; Service; Code[10])
        {
            TableRelation = Service.Service WHERE(Direction = FIELD(Direction));
        }
        field(24; section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                            "Plage Max" = FIELD(Service))*/;
        }
        field(25; Observation; Text[250])
        {
            Caption = 'Obsérvation';
        }
        field(26; "Nbr personnel affectes"; Integer)
        {
            CalcFormula = Count("FOR-Liste demande Formation" WHERE("N° Sequence" = FIELD("Training No.")));
            Caption = 'Nbre de personnels affectés';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Valideur; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom valideur");
            end;
        }
        field(28; "Nom valideur"; Text[50])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD(Valideur)));
            FieldClass = FlowField;
        }
        field(29; "Date validation"; Date)
        {
        }
        field(30; "Nature demande"; Option)
        {
            OptionCaption = 'Non programmée,Programmée';
            OptionMembers = "Non programmee",Programmee;
        }
    }

    keys
    {
        key(Key1; "Training No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF RecGFormation.FINDLAST THEN
            "Training No." := RecGFormation."Training No." + 1
        ELSE
            "Training No." := 1;
    end;

    var
        PostCode: Record 225;
        Employee: Record 5200;
        RecGFormation: Record "FOR-Formations";
        RecGCentreFormation: Record "FOR-Centres Formations";
        RecGThemes: Record "FOR-Themes Formations";
}

