PageExtension 50307 "No. Series_PagEXT" extends "No. Series"
{

    layout
    {
        // modify(code)
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify(Description)
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify(StartDate)
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify(StartNo)
        // {
        //     //Editable = ModifierNoSeries;

        //     Enabled = ModifierNoSeries;
        //     Visible = ModifierNoSeries;
        // }
        // modify(EndNo)
        // {
        //     //Editable = ModifierNoSeries;
        //     Enabled = ModifierNoSeries;
        //     Visible = ModifierNoSeries;
        // }
        // modify(LastDateUsed)
        // {
        //     //Editable = ModifierNoSeries;
        //     Enabled = ModifierNoSeries;
        //     Visible = ModifierNoSeries;
        // }
        // modify(LastNoUsed)
        // {
        //     //Editable = ModifierNoSeries;
        //     Enabled = ModifierNoSeries;
        //     Visible = ModifierNoSeries;
        // }
        // modify(WarningNo)
        // {
        //     //Editable = ModifierNoSeries;

        // }
        // modify(IncrementByNo)
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify("Default Nos.")
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify("Manual Nos.")
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify("Date Order")
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify(AllowGapsCtrl)
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify(Implementation)
        // {
        //     //Editable = ModifierNoSeries;
        // }
        // modify(NoSeriesLinesPart)
        // {
        //     Enabled = ModifierNoSeries;
        // }
        // modify(NoSeriesRelationsPart)
        // {
        //     Enabled = ModifierNoSeries;
        // }


    }
    actions
    {
        // modify("&Series")
        // {
        //     Enabled = ModifierNoSeries;
        // }
        // modify(Lines)
        // {
        //     Enabled = ModifierNoSeries;
        // }
        // modify(Relationships)
        // {
        //     Enabled = ModifierNoSeries;
        // }
        // modify(TestNoSeriesSingle)
        // {
        //     Enabled = ModifierNoSeries;
        // }
        // modify(ShowAll)
        // {
        //     Enabled = ModifierNoSeries;
        // }
        // modify(ShowExpiring)
        // {
        //     Enabled = ModifierNoSeries;

        // }
        // modify(TestNoSeries)
        // {
        //     Enabled = ModifierNoSeries;
        // }
    }
    trigger OnAfterGetRecord()
    begin
        //GL20224
        // Recherche param utilisateur de l'utilisateur connecté
        // if UserSetup.Get(UserId) then
        //     ModifierNoSeries := UserSetup."Permission Data Editor"
        // else
        //     ModifierNoSeries := false; // par défaut non modifiable

    end;

    trigger OnOpenPage()
    begin
        //GL20224
        // Recherche param utilisateur de l'utilisateur connecté
        // if UserSetup.Get(UserId) then
        //     ModifierNoSeries := UserSetup."Permission Data Editor"
        // else
        //     ModifierNoSeries := false; // par défaut non modifiable
        //                                //GL2024


    end;

    trigger OnAfterGetCurrRecord()
    begin
        //GL20224
        // Recherche param utilisateur de l'utilisateur connecté
        // if UserSetup.Get(UserId) then
        //     ModifierNoSeries := UserSetup."Permission Data Editor"
        // else
        //     ModifierNoSeries := false; // par défaut non modifiable
        //                                //GL2024


    end;










    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     if not HasPermission() then
    //         Error('Vous n’avez pas l’autorisation d’insérer dans No. Series.');
    // end;

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     if not HasPermission() then
    //         Error('Vous n’avez pas l’autorisation d’insérer dans No. Series.');
    // end;

    // trigger OnModifyRecord(): Boolean
    // begin
    //     if not HasPermission() then
    //         Error('Vous n’avez pas l’autorisation de modifier dans No. Series.');
    // end;

    // trigger OnDeleteRecord(): Boolean
    // begin
    //     if not HasPermission() then
    //         Error('Vous n’avez pas l’autorisation de supprimer dans No. Series.');
    // end;

    local procedure HasPermission(): Boolean
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."Permission Data Editor")
        else
            exit(false);
    end;

    var
        [InDataSet]
        ModifierNoSeries: Boolean;
        UserSetup: Record "User Setup";
}



