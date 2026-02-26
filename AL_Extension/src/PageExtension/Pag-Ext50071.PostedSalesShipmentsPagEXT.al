PageExtension 50071 "Posted Sales Shipments_PagEXT" extends "Posted Sales Shipments"
{

    layout
    {
        addafter("Location Code")
        {
            //HS
            field(Avancement; Format(Rec.Avancement) + '%')
            {
                ApplicationArea = all;
                Caption = 'Avancement Cumulé (%)';
                //  ExtendedDatatype = Ratio;
                //  MaxValue = 100;
                Editable = false;
                Style = Favorable;
                StyleExpr = true;
                //  DecimalPlaces = 2 : 2;

            }
            field("Montant Cumulé"; Rec."Montant Cumulé")
            {
                ApplicationArea = all;
                Caption = 'Montant Cumulé';
                //  ExtendedDatatype = Ratio;
                //  MaxValue = 100;
                Editable = false;
                Style = Unfavorable;
                StyleExpr = true;
                DecimalPlaces = 3 : 3;

            }
            //HS
        }
        addafter("No.")
        {
            field("External Document No.2"; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Sell-to Post Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }

        addafter("Shipping Agent Code")
        {
            field("Date Debut Decompte"; Rec."Date Debut Decompte")
            {
                ApplicationArea = all;
            }
            field("Date Fin Decompte"; Rec."Date Fin Decompte")
            {
                ApplicationArea = all;
            }
        }

    }
    //HS
    trigger OnOpenPage()
    var

    begin
        XAvancement := 0;
        XSommeAmount := 0;
        RecSalesShipmentHeader.Reset();
        RecSalesShipmentHeader.SetCurrentKey("No.");
        RecSalesShipmentHeader.SetAscending("No.", true);
        RecSalesShipmentHeader.SetRange("Order No.", Rec."Order No.");
        if RecSalesShipmentHeader.findset() then begin
            repeat
                SommeSHipmentQty := 0;
                SommeOrderQty := 0;
                SommeAmount := 0;
                Montantexcute := 0;
                RecSlalesShipmentLine.Reset();
                RecSlalesShipmentLine.SetRange("Document No.", RecSalesShipmentHeader."No.");
                RecSlalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
                if RecSlalesShipmentLine.FindSet() then begin
                    repeat
                        SommeSHipmentQty := SommeSHipmentQty + RecSlalesShipmentLine.Quantity;
                        SommeAmount := SommeAmount + RecSlalesShipmentLine."Unit Price";
                        if RecSalesLine.Get(RecSalesLine."Document Type"::Order, RecSlalesShipmentLine."order No.", RecSlalesShipmentLine."order Line No.") then begin
                            SommeOrderQty := SommeOrderQty + RecSalesLine.Quantity;
                            Montantexcute := Montantexcute + RecSalesLine."Line Amount";
                        end;
                    until RecSlalesShipmentLine.Next() = 0;
                end;
                if SommeOrderQty <> 0 then begin
                    RecSalesShipmentHeader.Avancement := Round(XAvancement + (SommeSHipmentQty / SommeOrderQty) * 100, 0.01, '=');
                    XAvancement := RecSalesShipmentHeader.Avancement;
                    RecSalesShipmentHeader."Montant Cumulé" := XSommeAmount + ((SommeSHipmentQty * SommeAmount) / Montantexcute) * 100;
                    XSommeAmount := RecSalesShipmentHeader."Montant Cumulé";
                    RecSalesShipmentHeader.Modify();
                end;

            until RecSalesShipmentHeader.Next() = 0;
        end;


    end;

    //HS
    trigger OnAfterGetRecord()
    var
    begin




    end;

    var
        SommeSHipmentQty, SommeOrderQty, SommeAmount, XSommeAmount, Montantexcute : Decimal;
        XAvancement: Decimal;
        RecSalesShipmentHeader: Record "Sales Shipment Header";
        RecSlalesShipmentLine: Record "Sales Shipment Line";
        RecSalesheader: Record "Sales Header";
        RecSalesLine: Record "Sales Line";

}


