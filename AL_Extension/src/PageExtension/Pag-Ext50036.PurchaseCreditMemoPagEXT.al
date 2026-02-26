PageExtension 50036 "Purchase Credit Memo_PagEXT" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Applies-to Doc. No.2"; Rec."Applies-to Doc. No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }

        addafter("VAT Bus. Posting Group")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;
            }
            field("Posting Description2"; wDescr)
            {
                ApplicationArea = all;
                caption = 'Posting Description';
                trigger OnValidate()
                begin
                    //POSTING_DESC
                    rec."Posting Description" := wDescr;
                    //POSTING_DESC//
                end;
            }
            field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
            }

        }

        addafter("Pay-to Contact No.")
        {
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = all;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        modify(Post)
        {
            Visible = false;

        }
        modify(Release)
        {
            trigger onbeforeaction()
            var
                myInt: Integer;
            begin
                rec."Posting Description" := Format(rec."Document Type") + ' ' + rec."Pay-to Name" + ' - Affaire ' + rec."Job No.";

            end;
        }

        addafter(Post)
        {

            action(Post2)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Valider';
                Image = PostOrder;

                trigger OnAction()
                var

                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin

                    // RB SORO 30/09/2015 VERIFIER N° doc. lettrage
                    //    rec.TESTFIELD("Applies-to Doc. No.");
                    // RB SORO 30/09/2015 VERIFIER N° doc. lettrage

                    IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
                    //origin code : CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)",Rec);
                    BEGIN
                        //FACTURATION_ACHAT
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            Currpage.PurchLines.page.CalcInvDisc;

                            COMMIT;
                            rec.GET(rec."Document Type", rec."No.");
                        END;
                        rec."Posting Description" := Format(rec."Document Type") + ' ' + rec."Pay-to Name" + ' - Affaire ' + rec."Job No.";
                        rec.Modify();
                        wPurchPost.InitRequest(FALSE, FALSE);
                        wPurchPost.RUN(Rec);
                        //FACTURATION_ACHAT//
                    END;
                end;
            }
        }
        addafter(Post_Promoted)
        {
            actionref(Post21; Post2)
            {

            }
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        addafter(PostAndPrint)
        {
            action("Post and &Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Valider et i&mprimer';
                Image = PostPrint;


                trigger OnAction()
                VAR
                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin


                    IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
                    //Origin code : CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print",Rec);
                    //FACTURATION_ACHAT
                    BEGIN
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            Currpage.PurchLines.page.CalcInvDisc;
                            COMMIT;
                        END;
                        wPurchPost.InitRequest(TRUE, FALSE);
                        wPurchPost.RUN(Rec);
                        //FACTURATION_ACHAT//
                    END;
                end;
            }
        }
        addafter(PostAndPrint_Promoted)
        {
            actionref("Post and &Print1"; "Post and &Print")
            {

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
    end;

    var
        wPurchPost: Codeunit "Purch. Order - Post";
        wDescr: Text[100];
        PurchSetup: Record "Purchases & Payables Setup";
}

