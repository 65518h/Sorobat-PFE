pageextension 50300 "Posted Invt. Shipmentsext" extends "Posted Invt. Shipments"
{
    layout
    {
        addafter("Location Code")
        {
            field("Date Saisie"; Rec."Date Saisie")
            {
                ApplicationArea = All;
                ToolTip = 'Date when the shipment was entered.';
            }
            field(Utilisateur; Rec.Utilisateur)
            {
                ApplicationArea = All;
                ToolTip = 'User who entered the shipment.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
    begin
        RecUserSetup.Get(UserId);
        // Rec.FilterGroup(0);
        // if RecUserSetup."Filtre Magasin" <> '' then
        //     Rec.SetRange("Location Code", RecUserSetup."Filtre Magasin");
        // Rec.FilterGroup(2);
    end;

    var
        myInt: Integer;
}