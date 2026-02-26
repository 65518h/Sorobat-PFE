Page 50088 "Decharge Facture Enreg."
{
    PageType = List;
    SourceTable = "Purch. Inv. Header";
    SourceTableView = sorting("No.")
                      where(Imprimer = const(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Decharge Facture Enreg.';
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
                    field("Vendor Invoice No."; rec."Vendor Invoice No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Amount Including VAT"; rec."Amount Including VAT")
                    {
                        ApplicationArea = all;
                    }
                    field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                    {
                        ApplicationArea = all;
                    }
                    field("Decharge"; rec.Decharge)
                    {
                        ApplicationArea = all;
                        Caption = 'Discharge';

                        trigger OnValidate()
                        begin
                            // CduPurchasePost.MiseAJourDecharge(rec."No.", rec.Decharge, false, '');
                            CurrPage.UPDATE(false);
                            //CurrForm.UPDATE;
                        end;
                    }
                }
            }

            // part("Liste Decharge Enreg."; "Liste Decharge Enreg.")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Hist Decharge';
            // }

        }
    }

    actions
    {
        area(Reporting)
        {
            action(Imprimer)
            {
                ApplicationArea = all;
                Caption = 'Imprimer';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    PurchInvHeader.Copy(Rec);
                    PurchInvHeader.SetRange(Decharge, true);
                    Report.RunModal(50097, true, false, PurchInvHeader);
                    CurrPage.Update;
                end;
            }
        }
        area(Processing)
        {
            action(HistDecharge)
            {
                ApplicationArea = all;
                Caption = 'Hist Decharge';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Liste Decharge Enreg.";

            }
        }
    }

    var
        NumDecharge: Code[20];
        PurchInvHeader: Record "Purch. Inv. Header";
        CduPurchasePost: Codeunit PurchPostEvent;
        Text001: label 'Lancer l''impression ?';
}

