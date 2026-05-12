TableExtension 50880 "Transfer HeaderEXT" extends "Transfer Header"
{
    fields
    {
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                Confirmed: Boolean;
                Text002: Label 'Do you want to change %1?';
            begin


                if xRec."Transfer-from Code" <> "Transfer-from Code" then begin

                    if HideValidationDialog or
                        (xRec."Transfer-from Code" = '')
                     then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text002, false, FieldCaption("Transfer-from Code"));


                    // if not Confirmed then
                    //     // >> HJ SORO 13-06-2015
                    //     "Chantier Origine" := Location.Affectation;
                    // // >> HJ SORO 13-06-2015
                end;





                IF Location.GET("Transfer-from Code") THEN
                    Validate("Shortcut Dimension 2 Code", Location.Affaire);

            end;

        }

        modify("Transfer-to Code")
        {
            trigger OnAfterValidate()
            begin
                // RB SORO 30/05/2015
                // "In-Transit Code" := 'TRANSIT';
                // RB SORO 30/05/2015
            end;

            /*GL2024   trigger OnLookup()
               begin
                   IF page.RUNMODAL(page::"Location List 2", Location) = ACTION::LookupOK THEN
                       "Transfer-to Code" := Location.Code;
                   // RB SORO 30/05/2015
                   "In-Transit Code" := 'TRANSIT';
                   // RB SORO 30/05/2015

                   // >> HJ SORO 13-06-2015
                   IF Location.GET("Transfer-to Code") THEN "Chantier Destination" := Location.Affectation;
                   // >> HJ SORO 13-06-2015
               end;*/
        }

        field(50000; Observation; Text[100])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50001; "N° Materiel"; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
            TableRelation = Véhicule;
        }
        field(50002; Materiel; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
            TableRelation = Resource where(Type = const(Machine));
        }
        field(50003; Receptioneur; Text[30])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50004; "Id Expediteur"; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50005; "Id Receptioneur"; Code[20])
        {
            Description = 'RB SORO 30/05/2015';
            TableRelation = Salarier;
        }
        field(50006; "Date Saisie"; Date)
        {
            Description = 'RB SORO 30/05/2015';
        }
        field(50007; "Chantier Origine"; Code[20])
        {
            Description = 'HJ SORO 13-06-2015';
            TableRelation = Job;
        }
        field(50008; "Chantier Destination"; Code[20])
        {
            Description = 'HJ SORO 13-06-2015';
            TableRelation = Job;
        }



        field(50009; Filtre; boolean)
        {

        }
        field(50010; "N° Demande Achat"; Code[20])
        {
            Editable = false;

        }
    }
    trigger OnAfterInsert()
    begin

        // >> HJ DSFT 04-10-2012
        "Assigned User ID" := USERID;
        "Date Saisie" := TODAY;
        // >> HJ DSFT 04-10-2012
    end;

    trigger oninsert()
    begin
        // RB SORO 30/05/2015

        IF RecUserSetup.GET(USERID) THEN;
        /*   IF RecUserSetup."Mgasin Origine Transf" <> '' THEN
               rec."Transfer-from Code" := RecUserSetup."Mgasin Origine Transf";*/
    end;



    var
        Location: Record Location;
        RecUserSetup: Record "User Setup";
}

