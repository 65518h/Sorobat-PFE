PageExtension 50100 "Gen. Product Posting G_PagEXT" extends "Gen. Product Posting Groups"
{
    layout
    {
        addafter("Auto Insert Default")
        {
            field("Entry Type"; Rec."Entry Type")
            {
                ApplicationArea = all;
            }
            field("Default Type"; Rec."Default Type")
            {
                ApplicationArea = all;
            }
            field(Summarize; Rec.Summarize)
            {
                ApplicationArea = all;
            }
            field(Totaling; Rec.Totaling)
            {
                ApplicationArea = all;
            }
            field(Indentation; Rec.Indentation)
            {
                ApplicationArea = all;
            }
            // field("Compte Achat"; Rec."Compte Achat")
            // {
            //     ApplicationArea = all;
            // }
            field("Compte Vente"; Rec."Compte Vente")
            {
                ApplicationArea = all;
            }
            field("Compte Achat Paramétré"; Rec."Compte Achat Paramétré")
            {
                ApplicationArea = all;
            }
            field("Compte Vente Paramétré"; Rec."Compte Vente Paramétré")
            {
                ApplicationArea = all;
            }
            field("Bal. Job No."; Rec."Bal. Job No.")
            {
                ApplicationArea = all;
            }
            field("Nbr Article Affecte"; Rec."Nbr Article Affecte")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Nbr Article field.', Comment = '%';
            }
        }
        addafter(Description)
        {
            field("Global Dimension 4 Code"; Rec."Global Dimension 4 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 4 Code field.', Comment = '%';
            }
        }
    }

    actions
    {
        addafter("&Setup")
        {
            action(Update)
            {
                Caption = 'Update';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    IF GeneralLedgerSetup.GET THEN
                        IF NOT GeneralLedgerSetup."Utiliser Update Code Nature" THEN ERROR(Text002);
                    IF GenProductPostingGroup.FINDFIRST THEN
                        REPEAT
                            GeneralPostingSetup."Gen. Bus. Posting Group" := '';
                            GeneralPostingSetup."Gen. Prod. Posting Group" := GenProductPostingGroup.Code;
                            GeneralPostingSetup."Sales Account" := GenProductPostingGroup."Compte Vente";
                            GeneralPostingSetup."Sales Line Disc. Account" := GenProductPostingGroup."Compte Vente";
                            GeneralPostingSetup."Sales Inv. Disc. Account" := GenProductPostingGroup."Compte Vente";
                            GeneralPostingSetup."Sales Credit Memo Account" := GenProductPostingGroup."Compte Vente";
                            // GeneralPostingSetup."Purch. Account" := GenProductPostingGroup."Compte Achat";
                            // GeneralPostingSetup."Purch. Line Disc. Account" := GenProductPostingGroup."Compte Achat";
                            // GeneralPostingSetup."Purch. Inv. Disc. Account" := GenProductPostingGroup."Compte Achat";
                            // GeneralPostingSetup."Purch. Credit Memo Account" := GenProductPostingGroup."Compte Achat";
                            GeneralPostingSetup."COGS Account" := '31100013';
                            GeneralPostingSetup."Inventory Adjmt. Account" := '31100013';
                            GeneralPostingSetup."Direct Cost Applied Account" := '31100013';
                            IF NOT GeneralPostingSetup.INSERT THEN GeneralPostingSetup.MODIFY;
                        UNTIL GenProductPostingGroup.NEXT = 0;
                    IF GenBusinessPostingGroup.FINDFIRST THEN
                        REPEAT
                            IF GenProductPostingGroup.FINDFIRST THEN
                                REPEAT
                                    GeneralPostingSetup."Gen. Bus. Posting Group" := GenBusinessPostingGroup.Code;
                                    GeneralPostingSetup."Gen. Prod. Posting Group" := GenProductPostingGroup.Code;
                                    GeneralPostingSetup."Sales Account" := GenProductPostingGroup."Compte Vente";
                                    GeneralPostingSetup."Sales Line Disc. Account" := GenProductPostingGroup."Compte Vente";
                                    GeneralPostingSetup."Sales Inv. Disc. Account" := GenProductPostingGroup."Compte Vente";
                                    GeneralPostingSetup."Sales Credit Memo Account" := GenProductPostingGroup."Compte Vente";
                                    // GeneralPostingSetup."Purch. Account" := GenProductPostingGroup."Compte Achat";
                                    // GeneralPostingSetup."Purch. Line Disc. Account" := GenProductPostingGroup."Compte Achat";
                                    // GeneralPostingSetup."Purch. Inv. Disc. Account" := GenProductPostingGroup."Compte Achat";
                                    // GeneralPostingSetup."Purch. Credit Memo Account" := GenProductPostingGroup."Compte Achat";
                                    GeneralPostingSetup."COGS Account" := '31100013';
                                    GeneralPostingSetup."Inventory Adjmt. Account" := '31100013';
                                    GeneralPostingSetup."Direct Cost Applied Account" := '31100013';
                                    IF NOT GeneralPostingSetup.INSERT THEN GeneralPostingSetup.MODIFY;

                                UNTIL GenProductPostingGroup.NEXT = 0;
                        UNTIL GenBusinessPostingGroup.NEXT = 0;
                    MESSAGE(Text001);

                end;
            }
            action(UpdateNatures)
            {
                Caption = 'Update Axe NATURES';
                ApplicationArea = all;
                Image = UpdateXML;
                trigger OnAction()
                var
                    RecLItem: Record Item;
                begin
                    IF rec.FINDFIRST THEN
                        REPEAT
                            RecLItem.Reset();
                            RecLItem.SetRange("Gen. Prod. Posting Group", rec.Code);
                            RecLItem.SetRange(Blocked, false);
                            if RecLItem.FindFirst() then
                                repeat
                                    RecLItem.ValidateShortcutDimCode(4, Rec."Global Dimension 4 Code");
                                until RecLItem.Next() = 0;
                        until Rec.Next() = 0;
                    Message('Traitement terminée');
                end;


            }
        }
        addafter("&Setup_Promoted")
        {
            actionref(Update1; Update)
            {

            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;

    var

    VAR
        GeneralPostingSetup: Record "General Posting Setup";
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Text001: label 'Task completed successfully';
        Text002: label 'Update parameters for the nature code name allowed for this company';
}