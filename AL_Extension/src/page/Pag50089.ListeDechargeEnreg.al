Page 50089 "Liste Decharge Enreg."
{
    PageType = list;
    SourceTable = "Purch. Inv. Header";
    SourceTableView = sorting("N° Decharge")
                      where("N° Decharge" = filter(<> ''), Imprimer = const(true));
    Caption = 'Liste Decharge Enreg.';
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
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
                Caption = 'Cancel Discharge';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text002) then exit;
                    PurchInvHeader.Reset;
                    NumInstance := 0;
                    Compteur := 0;
                    PurchInvHeader.Copy(Rec);
                    if PurchInvHeader.FindFirst then
                        repeat
                            Compteur += 1;
                            if Compteur = 1 then begin
                                NumDecharge := PurchInvHeader."N° Decharge";
                                NumInstance := 1;
                            end;
                            if NumDecharge <> PurchInvHeader."N° Decharge" then
                                NumInstance += 1;
                        until PurchInvHeader.Next = 0;
                    if NumInstance > 1 then
                        Error(Text001);


                    PurchInvHeader.Reset;
                    PurchInvHeader.Copy(Rec);
                    if PurchInvHeader.FindFirst then
                        repeat
                        // CduPurchasePost.MiseAJourDecharge(PurchInvHeader."No.", false, false, '');
                        // CduPurchasePost.MiseAJourDecharge(PurchInvHeader."No.", false, true, '');
                        until PurchInvHeader.Next = 0;
                    CurrPage.Update;
                end;
            }
        }
    }

    var
        Compteur: Integer;
        NumDecharge: Code[20];
        NumInstance: Integer;
        Text001: Label 'You have selected more than one discharge sequence.';
        Text002: Label 'Confirm this action?';
        PurchInvHeader: Record "Purch. Inv. Header";

        CduPurchasePost: Codeunit PurchPostEvent;
}

