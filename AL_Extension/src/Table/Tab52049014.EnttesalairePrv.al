table 52049014 "En-tête salaire Prév."
{ //GL2024  ID dans Nav 2009 : "39001486"
    Caption = ' Employee payment Header';
    //    DrillDownPageID = "Liste Paies Prév.";
    // LookupPageID = "Liste Paies Prév.";

    fields
    {
        field(1; "N° Paie"; Code[20])
        {
        }
        field(2; "Année"; Integer)
        {
            Caption = 'Year';
        }
        field(3; "Nbre Mois"; Integer)
        {
            Caption = 'Month';
        }
        field(4; "Date de création"; Date)
        {
            Caption = 'Creation date';
            Editable = false;
        }
        field(5; "Date dernière modification"; Date)
        {
            Caption = 'Last modif. date';
            Editable = false;
        }
        field(6; "Souches de N°"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(8; "Désignation"; Text[60])
        {
            Caption = 'Description';
        }
        field(50; "Filtre Groupe compta. salarié"; Code[10])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table0;
        }
        field(100; "Total brut du mois"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("MLigne salaire Prév."."Brut du Période" WHERE("Groupe compta. salarié" = FIELD("Filtre Groupe compta. salarié"),
                                                                              Année = FIELD(Année),
                                                                              "N° Paie" = FIELD("N° Paie")));
            Description = 'Sum("MLigne salaire Prév."."Brut du Période" WHERE (Groupe compta. salarié=FIELD(Filtre Groupe compta. salarié), Année=FIELD(Année), N° Paie=FIELD(N° Paie)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Cotisations soc. patronales"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Social Contributions Prév"."Real Amount : Employer" WHERE("No." = FIELD("N° Paie")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(300; "% Augmentatin Brut"; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Paie")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LnPaie.RESET;
        LnPaie.SETFILTER("N° Paie", "N° Paie");
        LnPaie.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    var
        "EnTêteSalaireEnreg": Record "En-tête salaire Prév.";
    begin
        ParamRessHum.GET;
        Année := DATE2DMY(WORKDATE, 3);
        "Souches de N°" := ParamRessHum."N° Paie Prev";
        GestionNoSouche.InitSeries("Souches de N°", xRec."Souches de N°", WORKDATE, "N° Paie", "Souches de N°");

        "Date de création" := WORKDATE;
    end;

    trigger OnModify()
    begin
        "Date dernière modification" := WORKDATE;
    end;

    var
        ParamRessHum: Record 5218;
        GestionNoSouche: Codeunit 396;
        EnTetePaie: Record "En-tête salaire Prév.";
        LnPaie: Record "MLigne salaire Prév.";
        "IndemnitésSalariés": Record "Indemnities Prev";
        CotisationSocLn: Record "Social Contributions Prév";
    //GL2024 Paie: Codeunit "Management of salary";


    procedure AssistEdit(AncPaie: Record "En-tête salaire Prév."): Boolean
    begin
    end;
}

