PageExtension 50271 "Payment Slip Subform_PagEXT" extends "Payment Slip Subform"
{
    layout
    {
        addafter("Debit Amount")
        {
            field("Motif Depense Ex"; rec."Motif Depense Ex")
            {
                ApplicationArea = all;

            }
            field("Type Ligne Credit"; rec."Type Ligne Credit")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Comptabilisé; rec.Comptabilisé)
            {
                ApplicationArea = all;
                Visible = false;

            }

        }
        modify("Account Type")
        {
            Visible = false;
        }
        modify("Account No.")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
            Caption = 'N° Piece De Paiement';
        }
        modify("Drawee Reference")
        {
            Visible = false;
        }

        addafter("Drawee Reference")
        {
            field("Drawee Reference Soroubat"; Rec."Drawee Reference Soroubat")
            {
                ApplicationArea = all;
            }
        }

        modify("Payment Address Code")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {

                ApplicationArea = all;
            }
            /*   field(Chantier; rec.Chantier)
               {
                   ApplicationArea = all;
               }
               field(Proprietaire; rec.Proprietaire)
               {
                   ApplicationArea = all;
               }
               field("Mode Paiement"; rec."Mode Paiement")
               {
                   ApplicationArea = all;
                   Visible = false;
               }
               field("Montant TVA sur Commission"; rec."Montant TVA sur Commission")
               {
                   ApplicationArea = all;

               }*/
            /*  field("Numero Seq"; rec."Numero Seq")
              {
                  ApplicationArea = all;
                  Visible = false;
              }
              field("Type Ligne Credit"; rec."Type Ligne Credit")
              {
                  ApplicationArea = all;

              }
              field(Comptabilisé; rec.Comptabilisé)
              {
                  ApplicationArea = all;

              }
              field("Motif Depense Ex"; rec."Motif Depense Ex")
              {
                  ApplicationArea = all;

              }*/
            // field("Bank Account Code"; rec."Bank Account Code")
            // {
            //     ApplicationArea = all;

            // }
            field("Line No.2"; rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }
        addafter("Account Type")
        {
            field("Type de compte"; rec."Type de compte")
            {
                ApplicationArea = all;
            }
            field("Code compte"; rec."Code compte")
            {
                ApplicationArea = all;
            }
            field("Account No.2"; Rec."Account No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Account No.")
        {


            field("Salarié"; rec.Salarié)
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Affectation Financiere"; rec."Affectation Financiere")
            {
                ApplicationArea = all;
                Visible = false;
            }
            // field("Code Opération"; rec."Code Opération")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            field("Currency Code"; rec."Currency Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Libellé"; rec.Libellé)
            {
                ApplicationArea = all;
            }
            field(Aval; rec.Aval)
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Montant Commission"; rec."Montant Commission")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Amount (LCY)"; rec."Amount (LCY)")
            {
                ApplicationArea = all;
                Editable = true;
                Visible = false;
            }
            field("Montant Initial"; rec."Montant Initial")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Montant Initial DS"; rec."Montant Initial DS")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Commentaires; rec.Commentaires)
            {
                ApplicationArea = all;
            }
            field("Bank Account Code2"; rec."Bank Account Code")
            {
                ApplicationArea = all;
                caption = 'Banque Bénéficiaire';
            }
            field("Currency Code2"; rec."Currency Code")
            {
                ApplicationArea = all;

            }
            field("Montant TVA sur Commission"; rec."Montant TVA sur Commission")
            {
                ApplicationArea = all;

            }
            field("Référence chèque"; rec."Référence chèque")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Header Account Type"; rec."Header Account Type")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Header Account No."; rec."Header Account No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("N° chèque"; rec."N° chèque")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Due Date")
        {
            field("Date Loyer"; rec."Date Loyer")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter(Amount)
        {
            field("Commande N°"; rec."Commande N°")
            {
                ApplicationArea = all;


                trigger OnLookup(var Text: Text): Boolean
                begin
                    PurchaseHeader.SetRange("Buy-from Vendor No.", rec."Account No.");
                    PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                    if Page.RunModal(Page::"Purchase List", PurchaseHeader) = Action::LookupOK then rec."Commande N°" := PurchaseHeader."No.";
                end;
            }
            field("Facture N°"; rec."Facture N°")
            {
                ApplicationArea = all;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange("Buy-from Vendor No.", rec."Account No.");
                    PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Invoice);
                    if Page.RunModal(Page::"Purchase List", PurchaseHeader) = Action::LookupOK then rec."Facture N°" := PurchaseHeader."No.";
                end;
            }
            field("Applies-to ID"; rec."Applies-to ID")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Numero Seq"; Rec."Numero Seq")
            {
                ApplicationArea = all;
            }
            field("Code Retenue à la Source"; rec."Code Retenue à la Source")
            {
                ApplicationArea = all;
            }
            field("Montant Retenue"; rec."Montant Retenue")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Montant Retenue Validé"; rec."Montant Retenue Validé")
            {
                ApplicationArea = all;

            }
            field("Montant Retenue TVA"; rec."Montant Retenue TVA")
            {
                ApplicationArea = all;

            }
            field("Montant Retenue G."; rec."Montant Retenue G.")
            {
                ApplicationArea = all;
            }
        }
        modify(IBAN)
        {
            Visible = false;
        }
        modify("SWIFT Code")
        {
            Visible = false;

        }
        modify("Has Payment Export Error")
        {
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        addafter("Bank City")
        {
            field(Benificiaire; rec.Benificiaire)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("RIB Checked")
        {
            field("Compte Bancaire"; rec."Compte Bancaire")
            {
                ApplicationArea = all;
            }


            field("Copied To No."; rec."Copied To No.")
            {
                ApplicationArea = all;

            }
            field("Bank Account Name1"; Rec."Bank Account Name")
            {
                ApplicationArea = all;
            }
            field("Affectation Client"; rec."Affectation Client")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Nom Client"; rec."Nom Client")
            {
                ApplicationArea = all;
                Visible = false;
                Editable = false;
            }
            /*   field(Source; Afficher)
               {
                   ApplicationArea = all;
                   Caption = 'Source';
                   Visible = false;

                   trigger OnValidate()
                   begin
                       //10868
                       PaymentHeader.SetRange("Mode Paiement", rec."Mode Paiement");
                       PaymentHeader.SetRange("N° Brouillard", rec."No.");
                       PaymentHeader.SetRange("Num Ligne", rec."Line No.");
                       Page.RunModal(Page::"Payment Slip", PaymentHeader);
                   end;
               }*/
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action("Calculer Retenue à la Source")
            {
                Caption = 'Calculer Retenue à la Source';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    CalculerRetenu;
                end;


            }
        }
        modify(Application)
        {
            Visible = false;
        }
        addafter(Application)
        {
            action(Application2)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Lettrage';
                ShortCutKey = 'Shift+F11';
                //ToolTip = 'Apply the customer or vendor payment on the selected payment slip line.';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"Payment-ApplyCopy", Rec);
                end;
            }
        }

    }

    var
        Afficher: Code[20];
        PaymentHeader: Record "Payment Header";
        PurchaseHeader: Record "Purchase Header";

    PROCEDURE LettrerFacture();
    VAR
        VendorLedgerEntry: Record 25;
        ListeFacturesLettrage: Record 50023;
    BEGIN
        IF rec."Applies-to ID" = '' THEN EXIT;
        VendorLedgerEntry.SETRANGE("Applies-to ID", rec."Applies-to ID");
        IF VendorLedgerEntry.FINDFIRST THEN
            REPEAT
                VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                ListeFacturesLettrage."Montant Facture" := VendorLedgerEntry."Remaining Amount";
                ListeFacturesLettrage.Sequence := VendorLedgerEntry."Entry No.";
                ListeFacturesLettrage.Fournisseurs := VendorLedgerEntry."Vendor No.";
                ListeFacturesLettrage."Numero Facture" := VendorLedgerEntry."Document No.";
                ListeFacturesLettrage."Montant Facture" := VendorLedgerEntry."Remaining Amount";
                ListeFacturesLettrage."Date Document" := VendorLedgerEntry."Posting Date";
                ListeFacturesLettrage.Description := VendorLedgerEntry.Description;
                ListeFacturesLettrage."ID Lettrage" := rec."Applies-to ID";
                ListeFacturesLettrage."Numero Reglement" := rec."No.";
                ListeFacturesLettrage."Nom Et Prenom" := rec.Libellé;
                ListeFacturesLettrage."Montant Reglement" := rec."Amount (LCY)";
                //  ListeFacturesLettrage.RS := rec."Code Retenue … la Source";
                ListeFacturesLettrage."Montant Retenu" := rec."Montant Retenue";
                ListeFacturesLettrage."Date Reglement" := rec."Posting Date";
                ListeFacturesLettrage."Date Echeance" := rec."Due Date";
                ListeFacturesLettrage."Numero Piece" := rec."External Document No.";
                ListeFacturesLettrage."Num Ligne Reglement" := rec."Line No.";
                IF ListeFacturesLettrage.INSERT THEN;

            UNTIL VendorLedgerEntry.NEXT = 0;
    END;

    procedure CalculerRetenu()
    begin
        rec.CalcRetenu;
    end;

    procedure Actualiser()
    begin
        rec.CalcAmount;
    end;

    procedure Affichelib() Lib: Text[100]
    var
        banq: Record "Bank Account";
        Frs: Record Vendor;
        cust: Record Customer;
        Cmpt: Record "G/L Account";
        Sal: Record Employee;
    begin
        Frs.Reset;
        cust.Reset;
        Cmpt.Reset;
        Sal.Reset;
        banq.Reset;
        Lib := '';
        if rec."Account No." <> '' then
            case rec."Account Type" of
                rec."account type"::Vendor:
                    begin
                        if Frs.Get(rec."Account No.") then
                            Lib := Frs.Name;
                    end;
                rec."account type"::"G/L Account":
                    begin
                        if Cmpt.Get(rec."Account No.") then
                            Lib := Cmpt.Name;
                    end;

                rec."account type"::Customer:
                    begin
                        if cust.Get(rec."Account No.") then
                            Lib := cust.Name;
                    end;
                /*"Account Type"::Salary : BEGIN
                   IF Sal.GET("Account No.") THEN
                      Lib:=Sal."Last Name"+' '+Sal."First Name";
                   END;*/
                rec."account type"::"Bank Account":
                    begin
                        if banq.Get(rec."Account No.") then
                            Lib := banq.Name;
                    end;
            end;

    end;

    procedure fractLine()
    begin
        rec.FractionnerLine;
    end;



    procedure REFCHEQUE(): Code[20]
    begin
        //>>>MBK:05/02/2010: Référence chèque
        exit(rec."Référence chèque");
    end;

    procedure GetLineNumber() LineNumber: Integer
    begin
        exit(rec."Line No.");
    end;

    procedure IsPrinted()
    begin
        //IF CONFIRM(Text003) THEN Imprimer:='O';
    end;

    procedure GetImprimer()
    begin
        //IF  Imprimer='O' THEN ERROR(Text004);
    end;

    procedure ViderIdLettrage()
    begin
        rec."Applies-to ID" := '';
    end;


    procedure MarkLines(ToMark: Boolean)
    var
        LineCopy: Record "Payment Line";
        NumLines: Integer;
    begin
        if ToMark then begin
            CurrPage.SetSelectionFilter(LineCopy);
            NumLines := LineCopy.Count();
            if NumLines > 0 then begin
                LineCopy.Find('-');
                repeat
                    LineCopy.Marked := true;
                    LineCopy.Modify();
                until LineCopy.Next() = 0;
            end else
                LineCopy.Reset();
            LineCopy.SetRange("No.", Rec."No.");
            LineCopy.ModifyAll(Marked, true);
        end else begin
            LineCopy.SetRange("No.", Rec."No.");
            LineCopy.ModifyAll(Marked, false);
        end;
        Commit();
    end;

}

