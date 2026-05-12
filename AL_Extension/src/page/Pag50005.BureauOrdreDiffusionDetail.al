Page 50005 "Bureau Ordre Diffusion Detail"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Bureau Ordre Diffusion";
    Caption = 'Bureau Ordre Diffusion Detail';

    SourceTableView = SORTING("Document N°", "Action Faite Le");
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Suivi; rec.Suivi)
                {
                    ApplicationArea = all;
                }
                field("Action"; rec.Action)
                {
                    ApplicationArea = all;
                    /*GL2024   Onformat()

   IF Action=Action::Diffusé THEN CurrForm.Action.UPDATEFORECOLOR(255);
   IF Action=Action::"Info Supplémantaire" THEN CurrForm.Action.UPDATEFORECOLOR(65280);
   IF Action=Action::Relancé THEN CurrForm.Action.UPDATEFORECOLOR(16711680);
   IF Action=Action::Rappel THEN CurrForm.Action.UPDATEFORECOLOR(255);
   IF Action=Action::Transféré THEN CurrForm.Action.UPDATEFORECOLOR(8421504);
   IF Action=Action::Clôturer THEN CurrForm.Action.UPDATEFORECOLOR(16711935);*/



                }
                field("Type Destination"; rec."Type Destination")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Action Faite Le"; rec."Action Faite Le")
                {
                    ApplicationArea = all;
                }
                field("Action Faite Par"; rec."Action Faite Par")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Service Destinataire"; rec."Service Destinataire")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Destinataire; rec.Destinataire)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Statut"; Rec."Statut")
                {
                    ApplicationArea = all;
                }
                field(Remarque; rec.Remarque)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ActionOnFormat;
    end;

    local procedure ActionOnFormat()
    begin
        if rec.Action = rec.Action::Diffusé then;
        if rec.Action = rec.Action::Relancé then;
        if rec.Action = rec.Action::Transféré then;
        if rec.Action = rec.Action::Clôturer then;

    end;
}

