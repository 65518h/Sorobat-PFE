Table 50016 "Entete Fiche Gasoil"
{
    DrillDownPageID = "Entete Gasoil";
    LookupPageID = "Entete Gasoil";

    fields
    {
        field(1; Journee; Date)
        {
            Editable = true;
        }
        field(2; Cuve; Code[20])
        {
            TableRelation = Location where(Affaire = field(Chantier));
        }
        field(3; "Index Depart"; Decimal)
        {
            Editable = false;

        }
        field(4; "Index Final"; Decimal)
        {
            Editable = false;
        }
        field(5; Utilisateur; Code[20])
        {
            Editable = false;
        }
        field(6; "Article Gasoil"; Code[20])
        {
            Editable = false;
        }
        field(7; Statut; Option)
        {
            Editable = true;
            OptionMembers = "En Cours",Valider;
        }
        field(8; "N° Fiche"; Code[20])
        {
        }
        field(9; "No."; Code[20])
        {
            Editable = true;
        }
        field(10; Synchronise; Boolean)
        {
        }
        field(11; "Num Sequence Syncro"; Integer)
        {

        }
        field(12; "Chantier"; Code[50])
        {

        }
        field(13; "No Series"; Code[10])
        {
            Caption = 'No Series', Comment = 'N° Série';
            TableRelation = "No. Series";
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Journee)
        {
        }
        key(Key3; Cuve, Journee)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        NoSeriesBatch: Codeunit "No. Series - Batch";
    begin
        // RecInventorySetup.Get;
        // if "No." = '' then begin
        //     TestNoSeries;
        //     NoSeriesMgt.InitSeries(GetNoSeriesCode, RecInventorySetup."Fiche Gasoil Nos."
        //     , Today, "No.", RecInventorySetup."Fiche Gasoil Nos.");
        // end;





        /*    if recLocation.Get(rec.Cuve) then;
            if "No." = '' then begin
                TestNoSeries;
                NoSeriesMgt.InitSeries(GetNoSeriesCode, recLocation."No. Series Gasoil"
                , Today, "No.", recLocation."No. Series Gasoil");

    end;*/

        // RecInventorySetup.GET;
        // IF "No." = '' THEN BEGIN
        //     TestNoSeries;
        //     NoSeriesMgt.InitSeries(GetNoSeriesCode, RecInventorySetup."Fiche Gasoil Nos."
        //     , TODAY, "No.", RecInventorySetup."Fiche Gasoil Nos.");
        // END;

        if "No." = '' then begin
            RecInventorySetup.Get();
            RecInventorySetup.TestField("Fiche Gasoil Nos.");
            if NoSeries.AreRelated(RecInventorySetup."Fiche Gasoil Nos.", xRec."No Series") then
                "No Series" := xRec."No Series"
            else
                "No Series" := RecInventorySetup."Fiche Gasoil Nos.";
            "No." := NoSeries.GetNextNo("No Series", WorkDate());

        end;


    end;

    var
        RecInventorySetup: Record "Inventory Setup";
        recLocation: Record Location;
        RecUserSetup: Record "User Setup";
        DecCentreDeGestion: Code[20];
        RespCenter: Record "Responsibility Center";
        NoSeriesMgt: Codeunit 396;
        Text001: label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        EneteGasoil: Record "Entete Fiche Gasoil";
        Text002: label 'N° Fiche Deja Saise';
        LigneGasoil: Record "Ligne Fiche Gasoil";


    procedure InitRecord()
    var
        lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";
    begin
        if recLocation.Get(rec.Cuve) then;
        NoSeriesMgt.SetDefaultSeries("No.", recLocation."No. Series Gasoil");
    end;


    procedure AssistEdit(OldPurchHeader: Record "Purchase Header"): Boolean
    begin
    end;

    local procedure TestNoSeries(): Boolean
    var
    //lSubscrSetup: Record 8001900;
    begin
        // if recLocation.Get(rec.Cuve) then;
        // recLocation.TestField("No. Series Gasoil");


        RecInventorySetup.GET;
        RecInventorySetup.TestField("Fiche Gasoil Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
    //lSubscrSetup: Record 8001900;
    begin
        if recLocation.Get(rec.Cuve) then;
        exit(recLocation."No. Series Gasoil");
    end;

    local procedure GetPostingNoSeriesCode(): Code[10]
    begin
    end;

    local procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[10]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024])
    var
        NoSeries: Record "No. Series";
    begin
        if (No <> '') and (NoSeriesCode <> '') then begin
            NoSeries.Get(NoSeriesCode);
            if NoSeries."Date Order" then
                Error(Text001);
        end;
    end;
}

