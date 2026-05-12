page 50023 "Suivi Bon Commande"
{
    PageType = Card;
    SourceTable = 39;
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order), Quantity = FILTER(<> 0), Status = CONST(Released));

    layout
    {
        area(content)
        {
            field(Choix; Choix)
            {
                Caption = 'BC Non Livrée';
                OptionCaption = 'Non Livré,Non Facturée,Facturée Non Payée';

                trigger OnValidate()
                begin
                    IF Choix = Choix::"Facturée Non Payée" THEN
                        Factur233eNonPaChoixOnValidate;
                    IF Choix = Choix::"Non Facturée" THEN
                        NonFactur233eChoixOnValidate;
                    IF Choix = Choix::"Non Livré" THEN
                        NonLivr233ChoixOnValidate;
                end;
            }
            field(Somme; Somme)
            {
                Caption = 'Montant';
                Editable = false;
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
            part(Factures; 50025)
            {
                Visible = FacturesVisible;
            }
            repeater(SUIVICMD)
            {
                Editable = false;
                ShowCaption = false;
                Visible = SUIVICMDVisible;
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                }
                field("Document No."; rec."Document No.")
                {
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                }
                field("Vendor.Name"; Vendor.Name)
                {
                    Caption = 'Nom';
                }
                field(Type; rec.Type)
                {
                }
                field("No."; rec."No.")
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field(Quantity; rec.Quantity)
                {
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                }
                field("Qty. Rcd. Not Invoiced"; rec."Qty. Rcd. Not Invoiced")
                {
                }
                field("Amt. Rcd. Not Invoiced"; rec."Amt. Rcd. Not Invoiced")
                {
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                }
            }

        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF Vendor.GET(rec."Buy-from Vendor No.") THEN;
    end;

    trigger OnInit()
    begin
        FacturesVisible := TRUE;
        SUIVICMDVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        rec.SETFILTER("Outstanding Quantity", '<>%1', 0);
    end;

    var
        Vendor: Record 23;
        PurchaseLine: Record 39;
        Choix: Option "Non Livré","Non Facturée","Facturée Non Payée";
        NomFrs: Text[50];
        Somme: Decimal;
        [InDataSet]
        SUIVICMDVisible: Boolean;
        [InDataSet]
        FacturesVisible: Boolean;
        Text19019493: Label 'BC Livrée Non Facturée';
        Text19031070: Label 'Facturée Non Payé';

    local procedure NonLivr233ChoixOnPush()
    begin
        SUIVICMDVisible := TRUE;
        FacturesVisible := FALSE;
        rec.RESET;
        rec.SETFILTER("Outstanding Quantity", '<>%1', 0);
        rec.SETFILTER(Status, '<>%1', Rec.Status::Archived);
        CurrPage.UPDATE;
    end;

    local procedure NonFactur233eChoixOnPush()
    begin
        Somme := 0;
        SUIVICMDVisible := TRUE;
        FacturesVisible := FALSE;
        rec.RESET;
        rec.SETFILTER("Qty. Rcd. Not Invoiced", '<>%1', 0);
        rec.SETFILTER(Status, '<>%1', Rec.Status::Archived);
        PurchaseLine.COPY(Rec);
        IF PurchaseLine.FINDFIRST THEN
            REPEAT
                Somme += PurchaseLine."Amt. Rcd. Not Invoiced";
            UNTIL PurchaseLine.NEXT = 0;
        CurrPage.UPDATE;
    end;

    local procedure Factur233eNonPaChoixOnPush()
    begin
        SUIVICMDVisible := FALSE;
        FacturesVisible := TRUE;
    end;

    local procedure NonLivr233ChoixOnValidate()
    begin
        NonLivr233ChoixOnPush;
    end;

    local procedure NonFactur233eChoixOnValidate()
    begin
        NonFactur233eChoixOnPush;
    end;

    local procedure Factur233eNonPaChoixOnValidate()
    begin
        Factur233eNonPaChoixOnPush;
    end;
}

