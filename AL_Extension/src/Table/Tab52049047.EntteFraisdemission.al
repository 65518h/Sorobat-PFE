
Table 52049047 "Entête Frais de mission"
{   //GL2024  ID dans Nav 2009 : "39004709"
    DrillDownPageID = "Liste Frais de mission";
    LookupPageID = "Liste Frais de mission";

    fields
    {
        field(1; "N° Frais"; Code[10])
        {
        }
        field(2; "Code Mission"; Code[10])
        {
            TableRelation = "Mission Enregistré" where("Code Convoyeur" = filter('NO'));

            trigger OnValidate()
            begin
                Miss.SetRange("N° Mission", "Code Mission");
                if Miss.Find('-') then
                    Validate("N° Salarié", Miss."Code Demandeur");
            end;
        }
        field(3; "N° Salarié"; Code[10])
        {
            TableRelation = Employee where(Status = const(Active));

            trigger OnValidate()
            begin
                if Salarié.Get("N° Salarié") then begin
                    "First name" := Salarié."First Name";
                    "Last Name" := Salarié."Last Name";
                    Validate("Global dimension 1", Salarié."Global Dimension 1 Code");
                    Validate("Global dimension 2", Salarié."Global Dimension 2 Code");
                end;
            end;
        }
        field(4; "Date Comptabilisation"; Date)
        {
        }
        field(5; "Code Utilisateur"; Code[10])
        {
        }
        field(8; "No. Series"; Code[10])
        {
        }
        field(9; "First name"; Text[30])
        {
        }
        field(10; "Last Name"; Text[30])
        {
        }
        field(50; "Global dimension 1"; Code[10])
        {
        }
        field(51; "Global dimension 2"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "N° Frais")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        IF "N° Frais" = '' THEN BEGIN
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("Fais de mission Nos.");

          NoSeriesMgt.InitSeries(HumanResSetup."Fais de mission Nos.",xRec."No. Series",0D,"N° Frais","No. Series");
        END;
          */
        //"Last Date Modified" := WORKDATE;
        "Code Utilisateur" := UserId;
        "Date Comptabilisation" := WorkDate;

    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit 396;
        "Salarié": Record Employee;
        Miss: Record "Mission Enregistré";


    procedure AssistEdit("AncEntêteFraisMission": Record "Entête Frais de mission"): Boolean
    begin
        /*
        WITH AncEntêteFraisMission DO BEGIN
          AncEntêteFraisMission := Rec;
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("Fais de mission Nos.");
          IF NoSeriesMgt.SelectSeries(HumanResSetup."Fais de mission Nos.",
                                      AncEntêteFraisMission."N° Frais",
                                      "N° Frais")
           THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Fais de mission Nos.");
            NoSeriesMgt.SetSeries("N° Frais");
            Rec := AncEntêteFraisMission;
            EXIT(TRUE);
          END;
        END;
        */

    end;
}

