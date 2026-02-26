pageextension 50303 "Invt. ReceiptEXT" extends "Invt. Receipt"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        addafter(Status)
        {
            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = all;
            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = all;
            }
            field("DYSJob Planning Line No."; Rec."DYSJob Planning Line No.") { ApplicationArea = all; }
            field("N° Materiel"; Rec."N° Materiel") { ApplicationArea = all; }
            field("Lieu Livraison / Provenance"; Rec."Lieu Livraison / Provenance") { ApplicationArea = all; }
            field(Receptioneur; Rec.Receptioneur) { ApplicationArea = all; }
            field("Index Vehicule"; Rec."Index Vehicule") { ApplicationArea = all; Style = StrongAccent; }
            field("N° Piéce"; Rec."N° Piéce") { ApplicationArea = all; }
            field(Observation; Rec.Observation) { ApplicationArea = all; }
            field(Benificiaire; Rec.Benificiaire) { ApplicationArea = all; }
            field("Date Saisie"; Rec."Date Saisie")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Utilisateur; Rec.Utilisateur)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        // Add changes to page layout here
    }

    actions
    {

        modify(Print)
        {
            Visible = false;
        }
        /*  modify("Create &Tracking from Reservation")
          {
              Visible = false;
          }*/
        modify("Post and &Print")
        {
            Visible = false;
            trigger OnBeforeAction()
            var
                UserSetup: Record "User Setup";
            begin
                // if UserSetup.Get(UserId) then begin
                //     if (UserSetup."N° matériel Obligatoire") and (Rec."N° Materiel" = '') then
                //         Error('Le champ "N° Materiel" est obligatoire. Veuillez le renseigner avant de poster.');
                // end;
                // if Rec."Lieu Livraison / Provenance" = '' then
                //     Error('Le champ "Lieu Livraison / Provenance" est obligatoire. Veuillez le renseigner avant de poster.');
                // if Rec.Receptioneur = '' then
                //     Error('Le champ "Réceptionneur" est obligatoire. Veuillez le renseigner avant de poster.');
            end;
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}