PageExtension 50230 "Inventory Posting Setup_PagEXT" extends "Inventory Posting Setup"
{
    actions
    {
        addafter(SuggestAccounts)
        {
            action("Copier Pout Tout Grp Cpt Stock")
            {
                Caption = 'Copy For All Group Chp Stock';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    TextL001: Label 'Start the assignment for warehouse %1 and for all stock accounting groups ?';
                BEGIN

                    // >> HJ DSFT 23-06-2012 IF RecInventoryPostingGroup.FINDFIRST THEN
                    REPORT.RUNMODAL(50049, TRUE, FALSE);
                    EXIT;
                    IF NOT CONFIRM(STRSUBSTNO(TextL001, rec."Location Code"), FALSE) THEN EXIT;
                    IF RecInventoryPostingGroup.FINDFIRST THEN
                        REPEAT
                            RecInventoryPostingSetup.TRANSFERFIELDS(Rec);
                            RecInventoryPostingSetup."Invt. Posting Group Code" := RecInventoryPostingGroup.Code;
                            IF RecInventoryPostingSetup.INSERT THEN;
                        UNTIL RecInventoryPostingGroup.NEXT = 0;
                    // >> HJ DSFT 23-06-2012
                end;
            }
        }
        addafter(SuggestAccounts_Promoted)
        {
            actionref("Copier Pout Tout Grp Cpt Stock1"; "Copier Pout Tout Grp Cpt Stock")
            {

            }
        }
    }

    var
        GLAcc: Record "G/L Account";
        "//hj DSFT": Integer;
        RecInventoryPostingSetup: Record "Inventory Posting Setup";
        RecInventoryPostingGroup: Record "Inventory Posting Group";
        RecLocation: Record Location;

    local procedure UpdateGLAccName(AccNo: Code[20])
    begin
        if not GLAcc.Get(AccNo) then
            Clear(GLAcc);
        //GL2024    Currpage.GLAccountName.UPDATE;
    end;
}

