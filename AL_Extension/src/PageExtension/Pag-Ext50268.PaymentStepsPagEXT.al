PageExtension 50268 "Payment Steps_PagEXT" extends "Payment Steps"
{


    layout
    {
        addbefore(Name)
        {


            field(Line; rec.Line)
            {
                ApplicationArea = all;
            }
            field("Previous Status"; rec."Previous Status")
            {
                ApplicationArea = all;
            }
            field("Next Status"; rec."Next Status")
            {
                ApplicationArea = all;
            }
            field("Header Nos. Series"; rec."Header Nos. Series")
            {
                ApplicationArea = all;
            }
            field("Statut Facture"; rec."Statut Facture")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Report No."; rec."Report No.")
            {
                ApplicationArea = all;
            }
            field("Action Type"; rec."Action Type")
            {
                ApplicationArea = all;
            }
            field(Agence; rec.Agence)
            {
                ApplicationArea = all;
            }
        }

        addafter(Name)
        {
            field(Affectation; CdeEtapes)
            {
                ApplicationArea = all;
                Caption = 'Affectation';

                trigger OnAssistEdit()
                begin
                    RecAutorisationEtape.SETRANGE("Type Reglement", rec."Payment Class");
                    RecAutorisationEtape.SETRANGE(Etape, rec.Line);
                    PAGE.RUNMODAL(Page::"Autorisation Etapes", RecAutorisationEtape);
                end;
            }
        }
    }
    actions
    {

    }

    VAR
        RecAutorisationEtape: Record "Autorisation Etapes2";
        CdeEtapes: Code[10];
}