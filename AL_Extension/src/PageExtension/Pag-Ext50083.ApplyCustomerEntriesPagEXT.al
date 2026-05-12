PageExtension 50083 "Apply Customer Entries_PagEXT" extends "Apply Customer Entries"
{
    layout
    {

        addafter("ApplyingCustLedgEntry.""Remaining Amount""")
        {
            field(ShowAppliedEntries; ShowAppliedEntries)
            {
                Caption = 'Show Only Selected Entries to Be Applied';
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    IF ShowAppliedEntries THEN BEGIN
                        IF CalcType = CalcType::"Gen. Jnl. Line" THEN
                            rec.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
                        ELSE BEGIN
                            CustEntryApplID := USERID;
                            IF CustEntryApplID = '' THEN
                                CustEntryApplID := '***';
                            rec.SETRANGE("Applies-to ID", CustEntryApplID);
                        END;
                    END ELSE
                        rec.SETRANGE("Applies-to ID");
                end;
            }
        }

        addbefore(AppliesToID)
        {
            field("Code Lettrage"; Rec."Code Lettrage")
            {
                ApplicationArea = all;

            }
        }

        addafter("CalcApplnRemainingAmount(""Remaining Amount"")")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Amount to Apply")
        {
            field("Value Date"; Rec."Value Date")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        addbefore("Set Applies-to ID")
        {
            action("Set Applying Entry")
            {
                ApplicationArea = all;
                Caption = 'Définir le lettrage d''écriture';
                ShortCutKey = 'Maj+F9';

                trigger OnAction()
                begin

                    IF CalcType = CalcType::Direct THEN BEGIN
                        rec."Applying Entry" := TRUE;
                        SetApplyingCustLedgEntry;
                    END ELSE
                        ERROR(Text001);
                end;
            }
            action("Remove Applying Entry")
            {
                ApplicationArea = all;
                Caption = 'Supprimer le lettrage des écritures';
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                begin

                    IF CalcType = CalcType::Direct THEN BEGIN
                        rec."Applying Entry" := FALSE;
                        SetApplyingCustLedgEntry;
                    END ELSE
                        ERROR(Text001);
                end;
            }



        }
        addafter("Set Applies-to ID_Promoted")
        {
            actionref("Set Applying Entry1"; "Set Applying Entry")
            {

            }
            actionref("Remove Applying Entry1"; "Remove Applying Entry")
            {

            }

        }
    }


    var
        Text001: label 'Vous n''êtes pas autorisé à choisir une nouvelle écriture lettrage lorsque vous sélectionnez Lettrer écritures.';
        gAddOnLicencePermission: Codeunit IntegrManagement;
        ShowAppliedEntries: Boolean;
        GenJnlLine: Record "Gen. Journal Line";
}