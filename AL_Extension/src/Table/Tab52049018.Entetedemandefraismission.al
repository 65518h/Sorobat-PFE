table 52049018 "Entete demande frais mission"
{ //GL2024  ID dans Nav 2009 : "39001496"
  // DrillDownPageID = 70155;
  //  LookupPageID = 70155;

    fields
    {
        field(1; "N° Demande"; Code[20])
        {
        }
        field(2; Demandeur; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                RecGEmp.RESET;
                RecGEmp.GET(Demandeur);
                "Nom Demandeur" := RecGEmp.FullName;
                EVALUATE("N° CIN", RecGEmp."N° Pièce D'identité");
                Qualite := RecGEmp."Job Title";
                "Global Dimension 1" := RecGEmp."Global Dimension 1 Code";
                "Global Dimension 2" := RecGEmp."Global Dimension 2 Code";
            end;
        }
        field(3; "Nom Demandeur"; Text[50])
        {
        }
        field(4; "N° CIN"; Integer)
        {
        }
        field(5; Qualite; Text[50])
        {
        }
        field(6; Destination; Code[20])
        {
            TableRelation = "Liste des destinations";

            trigger OnValidate()
            var
                RecLDestination: Record "Liste des destinations";
            begin
                IF RecLDestination.GET(Destination) THEN BEGIN
                    "Groupe destination" := RecLDestination."Groupe destination";
                END;
            end;
        }
        field(7; "Objet mission"; Code[20])
        {
            TableRelation = "Objet de mission";
        }
        field(8; Commentaire; Text[250])
        {
        }
        field(9; "Date debut"; Date)
        {
        }
        field(10; "Date fin"; Date)
        {
        }
        field(11; "Moyen transport"; Code[20])
        {
            TableRelation = "Liste Moyens de transport";
        }
        field(12; Statut; Option)
        {
            OptionCaption = 'En attente,En cours d'' approbation,Validé,Refusé';
            OptionMembers = "En attente","En cours approbation",Valide,Refuse;
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "Groupe destination"; Code[20])
        {
            TableRelation = "Dimension Value";
        }
        field(25; "Ordre mission cree"; Boolean)
        {
        }
        field(50; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(51; "Type mission"; Option)
        {
            OptionMembers = Locale,Etranger;
        }
    }

    keys
    {
        key(STG_Key1; "N° Demande")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLParamGRH: Record 5218;
    begin
        IF "N° Demande" = '' THEN BEGIN
            RecLParamGRH.GET();
            RecLParamGRH.TESTFIELD(RecLParamGRH."Expenses to repay Nos.");
            NoSeriesMgt.InitSeries(RecLParamGRH."Expenses to repay Nos.", xRec."No. Series", 0D, "N° Demande", "No. Series");
        END;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        RecGEmp: Record 5200;
}

