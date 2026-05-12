page 50395 "Purchase Request List Approved"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Request";
    Caption = 'Liste Demandes d''Achats approuvées';
    CardPageId = "PurchaseRequestHeaderApproved";
    SourceTableView = sorting("No.")
        where(Statut = filter(Approved | "partially supported" | "Fully Supported"));
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater("Purchase Request List")
            {
                Caption = 'Purchase Request List';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ApplicationArea = Basic;
                    Caption = 'Demandeur';
                }
                field(Service; Rec.Service)
                {
                    ApplicationArea = Basic;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = Basic;
                }
                field(Engin; Rec.Engin)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = Basic;
                    //  Caption = 'Etat DA';
                    Editable = false;
                    //   OptionCaption = 'Pending,accepted,refused';
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                // field("received"; Rec.received)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Description Engin"; Rec."Description Engin")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }


                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field("Date saisie"; Rec."Date saisie")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field("ID d'approbateur"; Rec."ID d'approbateur")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field("Date d'approbation"; Rec."Date d'approbation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = true;
                    Style = Unfavorable;

                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }

                field("Associated Purchase Order"; Rec."Associated Purchase Order")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
    begin
        RecUserSetup.Get(UserId);
        Rec.FilterGroup(0);
        if RecUserSetup."Filtre DA" = RecUserSetup."Filtre DA"::Utilisateur then
            Rec.SetRange("user ID", UserId);
        if RecUserSetup."Filtre DA" = RecUserSetup."Filtre DA"::Magasin then
            Rec.SetRange("Job No.", RecUserSetup."Affaire Par Defaut");
        if RecUserSetup."Filtre DA" = RecUserSetup."Filtre DA"::Interdiction then
            Rec.SetRange("No.", '');
        Rec.FilterGroup(2);
    end;
}