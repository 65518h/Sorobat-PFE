pageextension 50314 "Invt. ReceiptsEXT" extends "Invt. Receipts"
{
    layout
    {
        // Add changes to page layout here 
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
        Rec.FilterGroup(0);
        if RecUserSetup."Default Location" <> '' then
            Rec.SetRange("Location Code", RecUserSetup."Default Location");
        Rec.FilterGroup(2);
    end;

    var
        myInt: Integer;
}