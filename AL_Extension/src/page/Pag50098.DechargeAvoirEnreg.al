Page 50098 "Decharge Avoir Enreg."
{
    PageType = List;
    SourceTable = "Purch. Cr. Memo Hdr.";
    SourceTableView = sorting("No.")
                      where(Imprimer = const(false));
    ApplicationArea = all;
    UsageCategory = lists;
    Caption = 'Decharge Avoir Enreg.';
    layout
    {
        area(content)
        {
            group("Decharge Factures")
            {
                Caption = 'Decharge Factures';

                repeater(Control1)
                {
                    ShowCaption = false;

                    field("No."; rec."No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Amount Including VAT"; rec."Amount Including VAT")
                    {
                        ApplicationArea = all;
                    }
                    /*  field("Buy-from Vendor No."; "Buy-from Vendor No.")
                      {
                          ApplicationArea = all;
                      }*/
                    field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                    {
                        ApplicationArea = all;
                    }
                    field("Decharge"; rec.Decharge)
                    {
                        ApplicationArea = all;
                        Caption = 'Discharge';

                        trigger OnControlAddIn(Index: Integer; Data: Text)
                        begin
                            // CduPurchasePost.MiseAJourAvoir(rec."No.", rec.Decharge, false, '');
                            //CurrForm.UPDATE;
                        end;
                    }
                }
            }

            // part("Liste Decharge Avoir Enreg."; "Liste Decharge Avoir Enreg.")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Hist Decharge';
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action(Imprimer)
            {
                ApplicationArea = all;
                Caption = 'Imprimer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    PurchCrMemoHdr.Copy(Rec);
                    PurchCrMemoHdr.SetRange(Decharge, true);
                    Report.RunModal(50103, true, false, PurchCrMemoHdr);
                    CurrPage.Update;
                end;
            }
        }
    }

    var
        NumDecharge: Code[20];

        CduPurchasePost: Codeunit PurchPostEvent;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        Text001: label 'Lancer L''Impression ?';

        f: Record "Sales Cr.Memo Header";
}

