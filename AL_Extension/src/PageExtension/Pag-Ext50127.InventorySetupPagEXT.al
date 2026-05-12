PageExtension 50127 "Inventory Setup_PagEXT" extends "Inventory Setup"
{

    layout
    {
        addafter("Allow Inventory Adjustment")
        {
            field("Magasin de transfert"; Rec."Magasin de transfert")
            {
                ApplicationArea = all;
            }
        }
        addafter(Numbering)
        {
            group(Specifique)
            {
                Caption = 'Specific';
                field("Inventory Consumption Delay"; Rec."Inventory Consumption Delay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Consumption Delay field.', Comment = '%';
                }
                field("Model Journal"; Rec."Model Journal")
                {
                    ApplicationArea = all;
                }
                field("Nom Model De Feuille"; Rec."Nom Model De Feuille")
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    VAR
                        RecLGenJournalBatch: Record "Gen. Journal Batch";
                    begin

                        // >> HJ DSFT 27-03-2012
                        RecLGenJournalBatch.SETRANGE("Journal Template Name", rec."Model Journal");
                        IF page.RUNMODAL(0, RecLGenJournalBatch) = ACTION::LookupOK THEN rec."Nom Model De Feuille" := RecLGenJournalBatch.Name;
                        // >> HJ DSFT 27-03-2012
                    end;
                }
                field("Article Gasoil"; Rec."Article Gasoil")
                {
                    ApplicationArea = all;
                }
                field("Model Feuille Article"; Rec."Model Feuille Article")
                {
                    ApplicationArea = all;
                }
                field("Nom Fichier Synchro"; Rec."Nom Fichier Synchro")
                {
                    ApplicationArea = all;
                }

                field("Nom Model Par Defaut"; Rec."Nom Model Par Defaut")
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        // >> HJ DSFT 27-03-2012
                        ReItemJournalBatch.SETRANGE("Journal Template Name", rec."Model Feuille Article");
                        IF page.RUNMODAL(0, ReItemJournalBatch) = ACTION::LookupOK THEN
                            rec."Nom Model Par Defaut" := ReItemJournalBatch.Name;
                        // >> HJ DSFT 27-03-2012
                    end;
                }

                field("Fiche Gasoil Nos."; Rec."Fiche Gasoil Nos.")
                {
                    ApplicationArea = all;
                }
                // field("Magasin Bejat Lot2"; Rec."Magasin Bejat Lot2")
                // {
                //     ApplicationArea = all;
                // }
                // field("Magasin Bejat Lot3"; Rec."Magasin Bejat Lot3")
                // {
                //     ApplicationArea = all;
                // }


            }
        }

    }


    actions
    {

    }

    VAR
        ReItemJournalBatch: Record "Item Journal Batch";
}

