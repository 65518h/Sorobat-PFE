Page 50075 "Liste Decharge"
{
    PageType = ListPart;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("N° Decharge")
                      where("Document Type" = filter(Invoice | "Credit Memo" | "Return Order"), Imprimer = const(true), "N° Decharge" = filter(<> ''));
    Caption = 'Liste Decharge';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("N° Decharge"; rec."N° Decharge")
                {
                    ApplicationArea = all;
                }
                field("Date Decharge"; rec."Date Decharge")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No. "; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Annuler Decharge")
            {
                ApplicationArea = all;
                Caption = 'Annuler Decharge';
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    if not Confirm(Text002) then exit;
                    PurchaseHeader.Reset;
                    NumInstance := 0;
                    Compteur := 0;
                    PurchaseHeader.Copy(Rec);
                    if PurchaseHeader.FindFirst then
                        repeat
                            Compteur += 1;
                            if Compteur = 1 then begin
                                NumDecharge := PurchaseHeader."N° Decharge";
                                NumInstance := 1;
                            end;
                            if NumDecharge <> PurchaseHeader."N° Decharge" then NumInstance += 1;
                        until PurchaseHeader.Next = 0;
                    if NumInstance > 1 then Error(Text001);


                    PurchaseHeader.Reset;
                    PurchaseHeader.Copy(Rec);
                    if PurchaseHeader.FindFirst then
                        repeat
                            PurchaseHeader.Imprimer := false;
                            PurchaseHeader.Decharge := false;
                            PurchaseHeader."N° Decharge" := '';
                            //PurchaseHeader."Date Decharge";
                            PurchaseHeader.Modify;
                        until PurchaseHeader.Next = 0;
                    CurrPage.Update;
                end;
            }
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";
        Compteur: Integer;
        NumDecharge: Code[20];
        NumInstance: Integer;
        Text001: label 'Vous Avez Choisit Plus D''une Sequence De Decharge';
        Text002: label 'Confirmer Cette Action ?';
}

