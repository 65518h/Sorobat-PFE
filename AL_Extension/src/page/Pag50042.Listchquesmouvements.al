Page 50042 "List chèques mouvementés"
{
    //   //>>>MBK:05/02/2010: Référence chèque

    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Chèque mouvementé";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'List chèques mouvementés';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° ligne"; rec."N° ligne")
                {
                    ApplicationArea = all;
                }
                field("Code banque"; rec."Code banque")
                {
                    ApplicationArea = all;
                }
                field("Référence chèque"; rec."Référence chèque")
                {
                    ApplicationArea = all;
                }
                field("N°Chèque"; rec."N°Chèque")
                {
                    ApplicationArea = all;
                }
                field(Statut; rec.Statut)
                {
                    ApplicationArea = all;
                }
                field("N° Bordereu"; rec."N° Bordereu")
                {
                    ApplicationArea = all;
                }
                field("Statut Bordereau"; rec."Statut Bordereau")
                {
                    ApplicationArea = all;
                }
                field("N° Statut"; rec."N° Statut")
                {
                    ApplicationArea = all;
                }
                field("Statut Modifiable"; rec."Statut Modifiable")
                {
                    ApplicationArea = all;
                }
                field("N° Ligne Bordereu"; rec."N° Ligne Bordereu")
                {
                    ApplicationArea = all;
                }
                field("N° Fournisseur"; rec."N° Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Nom Fournisseur"; rec."Nom Fournisseur")
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
            action(Block)
            {
                ApplicationArea = all;
                Caption = 'Bloquer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Confirm(Text003, false) then exit;
                    rec.Statut := rec.Statut::Bloquer; // Initial
                    rec."N° Bordereu" := '';
                    rec."N° Ligne Bordereu" := 0;
                    rec."Statut Bordereau" := '';
                    rec."N° Statut" := 0;
                    rec.Modify;
                end;
            }
            action("Release")
            {
                ApplicationArea = all;
                Caption = 'Libérer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //IF NOT "Statut Modifiable"  THEN ERROR(Text002);
                    if not Confirm(Text001, false) then exit;
                    rec.Statut := 0; // Initial
                    rec."N° Bordereu" := '';
                    rec."N° Ligne Bordereu" := 0;
                    rec."Statut Bordereau" := '';
                    rec."N° Statut" := 0;
                    rec.Modify;
                    exit;
                    RecPaymentLine.SetRange("No.", rec."N° Bordereu");
                    RecPaymentLine.SetRange("N° chèque", rec."N°Chèque");
                    if RecPaymentLine.FindFirst then begin
                        rec.Statut := 0; // Initial
                        rec."N° Bordereu" := '';
                        rec."N° Ligne Bordereu" := 0;
                        rec."Statut Bordereau" := '';
                        rec."N° Statut" := 0;
                        rec.Modify;
                    end;
                end;
            }
        }
    }

    var
        RecPaymentLine: Record "Payment Line";
        Text001: label 'Confirm the release of this check.';
        Text002: label 'The status of the slip does not allow the release of this check; the status must be Initial.';
        Text003: label 'Confirm the blocking of this check.';
}

