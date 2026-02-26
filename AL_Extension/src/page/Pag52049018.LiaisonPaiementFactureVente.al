Page 52049018 "Liaison Paiement Facture Vente"
{//GL2024  ID dans Nav 2009 : "39004815"
    PageType = ListPart;
    SourceTable = "Liaison Paiement Facture Vente";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("N° Bordereaux"; REC."N° Bordereaux")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("N° Ligne"; REC."N° Ligne")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("N° Facture"; REC."N° Facture")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        RecSalesInvoiceHeader.Reset;
                        RecSalesInvoiceHeader.SetRange("No.", REC."N° Facture");
                        if RecSalesInvoiceHeader.FindFirst then begin
                            RecSalesInvoiceHeader.CalcFields("Amount Including VAT");
                            REC."Montant TTC" := RecSalesInvoiceHeader."Amount Including VAT";
                        end;
                    end;
                }
                field("Montant TTC"; REC."Montant TTC")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Commentaire; REC.Commentaire)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        RecLiaisonFactureVente.SetRange("N° Bordereaux", REC."N° Bordereaux");
        if RecLiaisonFactureVente.FindLast then begin
            REC."N° Ligne" := RecLiaisonFactureVente."N° Ligne" + 10000;
        end
        else
            REC."N° Ligne" := 10000;
    end;

    var
        RecLiaisonFactureVente: Record "Liaison Paiement Facture Vente";
        RecSalesInvoiceHeader: Record "Sales Invoice Header";
}

