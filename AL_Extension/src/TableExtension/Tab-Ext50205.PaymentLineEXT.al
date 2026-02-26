TableExtension 50205 "Payment LineEXT" extends "Payment Line"
{
    fields
    {

        modify(Amount)
        {
            //GL2024   DecimalPlaces = 0 : 3;
            trigger OnAfterValidate()
            begin
                // STD V2.00
                IF ("Montant Retenue" = 0) AND ("Montant Retenue Validé" = 0) AND ("Montant Retenue TVA" = 0)
                    AND ("Montant Retenue TVA Validé" = 0) AND ("Montant Commission" = 0) AND ("Montant Commission Validé" = 0)
                    AND ("Montant TVA sur Commission" = 0) AND ("Montant TVA sur Com. validé" = 0) THEN BEGIN
                    "Montant Initial" := Amount;
                    "Montant Initial DS" := "Amount (LCY)";
                END;
                // STD V2.00 
            end;
        }

        modify("Account No.")
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Account Type" = CONST(Salarier)) Salarier;

            trigger OnAfterValidate()
            begin
                //UpdateEntry(FALSE);

                // STD V2.00
                RecGVendor.RESET;
                RecGCustomer.RESET;
                RecGGLAccount.RESET;
                RecGEmployee.RESET;
                RecGBankAccount.RESET;
                Libellé := '';
                IF "Account No." <> '' THEN
                    CASE "Account Type" OF
                        "Account Type"::Vendor:
                            BEGIN
                                IF RecGVendor.GET("Account No.") THEN BEGIN
                                    "Groupe Comptabilisation" := RecGVendor."Vendor Posting Group";
                                    Libellé := RecGVendor.Name;
                                END;
                            END;
                        "Account Type"::"G/L Account":
                            BEGIN
                                IF RecGGLAccount.GET("Account No.") THEN
                                    Libellé := RecGGLAccount.Name;
                            END;

                        "Account Type"::Customer:
                            BEGIN
                                IF RecGCustomer.GET("Account No.") THEN BEGIN
                                    "Groupe Comptabilisation" := RecGCustomer."Customer Posting Group";
                                    Libellé := RecGCustomer.Name;
                                    "Drawee Reference" := CopyStr(RecGVendor.Name, 1, 10);
                                END
                            END;
                        "Account Type"::"Bank Account":
                            BEGIN
                                IF RecGBankAccount.GET("Account No.") THEN
                                    Libellé := RecGBankAccount.Name;

                            END;
                        "Account Type"::"Frais annexe":

                            BEGIN
                                IF RecGItemCharge.GET("Account No.") THEN
                                    Libellé := RecGItemCharge.Description;
                            END;
                        "Account Type"::Salarier:
                            BEGIN
                                IF RecGItemCharge.GET("Account No.") THEN
                                    Libellé := RecGItemCharge.Description;
                            END;
                    END;

                RecGVendor.RESET;
                RecGVendor.SETRANGE("No.", "Account No.");
                IF RecGVendor.FIND('-') THEN BEGIN
                    Libellé := RecGVendor.Name;
                    "Drawee Reference" := CopyStr(RecGVendor.Name, 1, 10);
                END;
                RecGCustomer.RESET;
                RecGCustomer.SETRANGE("No.", "Account No.");
                IF RecGCustomer.FIND('-') THEN BEGIN
                    Libellé := RecGCustomer.Name;
                    "Drawee Reference" := CopyStr(RecGVendor.Name, 1, 10);
                END;
                RecGGLAccount.RESET;
                RecGGLAccount.SETRANGE("No.", "Account No.");
                IF RecGGLAccount.FIND('-') THEN BEGIN
                    Libellé := RecGGLAccount.Name;
                    "Drawee Reference" := CopyStr(RecGVendor.Name, 1, 10);
                END;
                // ST V2.00
                // >> HJ DSFT 09-02-2014
                IF "Due Date" <> 0D THEN BEGIN
                    "Annee Echeance" := DATE2DMY("Due Date", 3);
                    "Mois Echeance" := DATE2DMY("Due Date", 2);
                end;
                IF RecPaymentHeader.GET("No.") THEN BEGIN
                    "Compte Entete" := RecPaymentHeader."Account No.";
                    IF ((RecPaymentHeader."Account No." = 'CA001001') OR ("Account No." = 'CA001001')) AND
                    (NOT "Caisse Chantier")
                     THEN
                        Caisse := TRUE ELSE
                        Caisse := FALSE;
                END;
                IF PaymentClass.GET("Payment Class") THEN BEGIN
                    IF ("Line No." = 1000) AND (PaymentClass."Credit Bancaire Avec Echeancie")
                      THEN
                        "Type Ligne Credit" := "Type Ligne Credit"::Emis;
                    IF PaymentClass.EXT THEN EX := TRUE;
                END;
                // >> HJ DSFT 09-02-2014

                // // >> HJ SORO 14-10-2015
                // IF RecPaymentHeader.GET("No.") THEN
                //     IF RecPaymentHeader."Account Type" = RecPaymentHeader."Account Type"::"Bank Account" THEN
                //         "Compte Bancaire" := RecPaymentHeader."Account No.";
                // RecPaymentHeader.CALCFIELDS("Status Name");
                // "Libelle Statut" := RecPaymentHeader."Status Name";
                // // >> HJ SORO 14-10-2015

            end;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            begin
                // >> HJ DSFT 09-02-2014
                // IF "Due Date" <> 0D THEN BEGIN
                if rec."Due Date" <> 0D then begin


                    "Annee Echeance" := DATE2DMY("Due Date", 3);
                    "Mois Echeance" := DATE2DMY("Due Date", 2);
                end;
                //  END;
                // >> HJ DSFT 09-02-2014
            end;
        }

        /* GL2024  modify("Posting Group")
           {
               Editable = true;
           }
           modify("Acc. Type Last Entry Debit")
           {
               Editable = true;
           }
           modify("Acc. No. Last Entry Debit")
           {
               Editable = true;
           }
           modify("Acc. No. Last Entry Credit")
           {
               Editable = true;
           }
           modify("Acc. Type Last Entry Credit")
           {
               Editable = true;
           }
           modify("P. Group Last Entry Debit")
           {
               Editable = true;
           }
           modify("P. Group Last Entry Credit")
           {
               Editable = true;
           }
           modify("Status No.")
           {
               Editable = true;
           }
             modify("Amount (LCY)")
           {
               Editable = true;
                DecimalPlaces=3:3;
           }
              modify("Posting Date")
           {
               Editable = true;
           }
           */
        modify("Drawee Reference")
        {
            Description = 'SDT V1.00';
        }


        modify("Bank Account Code")
        {



            Caption = 'Banque Bénéficiaire';

            trigger OnAfterValidate()
            begin
                if "Bank Account Code" <> '' then begin
                    if "Account Type" = "Account Type"::Vendor then begin
                        VendorBank.Get("Account No.", "Bank Account Code");
                        "Agency Code" := VendorBank.AGENCE;
                    end;
                end;
            end;
        }
        /* modify("Debit Amount")
         {
             trigger OnAfterValidate()
             begin
                 IF "Code Opération" = 'P1' THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTPAIE', TODAY, TRUE);
                 END;

                 IF "Code Opération" = 'P2' THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTAV', TODAY, TRUE);
                 END;

                 IF "Code Opération" = 'P3' THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTPRET', TODAY, TRUE);
                 END;



                 IF ("Type Caisse" = 3) AND ("Code Opération" <> 'P3') AND ("Code Opération" <> 'P2') AND ("Code Opération" <> 'P1') THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXT', TODAY, TRUE);
                 END;

                 IF ("Type Caisse" = 2) AND ("Code Opération" <> 'P3') AND ("Code Opération" <> 'P2') AND ("Code Opération" <> 'P1') THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTCE', TODAY, TRUE);
                 END;

                 //MH SORO 20-04-2021
                 RecPaymentHeader2.RESET;
                 RecPaymentHeader2.SETRANGE("No.", "No.");
                 IF RecPaymentHeader2.FINDFIRST THEN "N° Affaire" := RecPaymentHeader2."N° Affaire";
                 //MH SORO 20-04-2021
                 IF "Payment Class" = 'DECAISS-TRAITE-AVAL' THEN Aval := TRUE;

             end;
         }*/

        /* modify("Credit Amount")
         {
             trigger OnAfterValidate()
             begin
                 IF "Code Opération" = 'P1' THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTPAIE', TODAY, TRUE);
                 END;

                 IF "Code Opération" = 'P2' THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTAV', TODAY, TRUE);
                 END;

                 IF "Code Opération" = 'P3' THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTPRET', TODAY, TRUE);
                 END;



                 IF ("Type Caisse" = 3) AND ("Code Opération" <> 'P3') AND ("Code Opération" <> 'P2') AND ("Code Opération" <> 'P1') THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXT', TODAY, TRUE);
                 END;

                 IF ("Type Caisse" = 2) AND ("Code Opération" <> 'P3') AND ("Code Opération" <> 'P2') AND ("Code Opération" <> 'P1') THEN BEGIN
                     IF "Numero Seq" = '' THEN "Numero Seq" := NoSeriesManagment.GetNextNo('SEQEXTCE', TODAY, TRUE);
                 END;

                 //MH SORO 20-04-2021
                 RecPaymentHeader2.RESET;
                 RecPaymentHeader2.SETRANGE("No.", "No.");
                 IF RecPaymentHeader2.FINDFIRST THEN "N° Affaire" := RecPaymentHeader2."N° Affaire";
                 //MH SORO 20-04-2021
             end;
         }*/

        modify("External Document No.")
        {
            trigger OnBeforeValidate()
            begin
                // RB SOROU 14/04/2014
                /*GL2026  RecVendorPaymentLine.RESET;
                  RecVendorPaymentLine.SETRANGE("External Document No.", "External Document No.");
                  IF RecVendorPaymentLine.FINDFIRST THEN ERROR('N° Piece De Paiement Deja Saisie !');*/

                // RB SOROU 14/04/2014
            end;
        }

        field(50000; "External Invoice No."; Code[20])
        {
            Caption = 'External Invoice No.';
            Description = 'SDT V1.00';
        }
        field(50001; "Libellé"; Text[80])
        {
            Description = 'SDT V1.00';
            Editable = true;
        }
        field(50002; Exported; Boolean)
        {
            Caption = 'Exportée';
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50003; "Communication XRT"; Boolean)
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50004; "En Banque"; Boolean)
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50005; Annulation; Boolean)
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50006; "Type paiement"; Option)
        {
            Description = 'SDT V1.00';
            OptionCaption = 'Paiement,Avance';
            OptionMembers = Paiement,Avance;
        }
        field(50007; "N° commande"; Code[20])
        {
            Description = 'SDT V1.00';
        }
        field(50008; "Code Retenue à la Source"; Code[10])
        {
            Description = 'SDT V1.00';
            //  TableRelation = "Groupe Retenue".Code where("Type Retenue" = filter("à la source"));
        }
        field(50009; "Groupe Comptabilisation"; Code[10])
        {
            Description = 'SDT V1.00';
        }
        field(50010; "N° Bordereau"; Code[20])
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50011; Remplaced; Boolean)
        {
            Caption = 'Remplacé';
            Description = 'SDT V1.00';
        }
        field(50012; "Payement Crédit"; Boolean)
        {
            Description = 'SDT V1.00';
        }
        field(50013; "Compte Entete"; code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = "Bank Account";
        }
        field(50014; "Header Account Type"; Option)
        {
            Caption = 'Account Type Header';
            Description = 'SDT V1.00';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Salarier';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Salarier;
        }
        field(50015; "Header Account No."; Code[20])
        {
            Caption = 'N° Compte en‑tête';
            Description = 'SDT V1.00';
            Editable = true;
            TableRelation = if ("Header Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Header Account Type" = const(Customer)) Customer
            else
            if ("Header Account Type" = const(Vendor)) Vendor
            else
            if ("Header Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Header Account Type" = const("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Header Account Type" = CONST(Salarier)) Salarier;
        }
        /*  field(50016; Provisoire; Boolean)
          {
              Description = 'HJ SORO 11-09-2014';
          }*/
        field(50017; "Montant Retour"; Decimal)
        {
            Description = 'HJ SORO 11-09-2014';
        }
        field(50018; "Type Engagement"; Option)
        {
            Description = 'HJ DSFT 08-02-2014';
            OptionMembers = " ",Fournisseur,Banque,"Fournisseur Et Banque","Client Et Banque",Client;
        }
        field(50019; "Sens Engagement"; Option)
        {
            Description = 'HJ DSFT 08-02-2014';
            OptionMembers = " ","Débit","Crédit";
        }
        field(50037; Decharge; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50038; "Imprimer Decharge"; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50039; "N° Decharge"; Text[30])
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50040; "Date Decharge"; Date)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50041; Aval; Boolean)
        {
            Description = 'MH SORO 02/02/2022';
        }
        field(50050; "Montant Retenue"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                if ((Amount > 0) and ("Montant Retenue" > 0)) or ((Amount < 0) and ("Montant Retenue" < 0)) then
                    "Montant Retenue" := -"Montant Retenue";

                // Calc Montant Retenu
                if "Currency Code" <> '' then RecGCurrency.Get("Currency Code");
                if ("Montant Retenue" <> 0) and ("Montant Retenue Validé" = 0) and (RecGPaymentStatus."Calculer Retenue à la source") then begin
                    if "Currency Code" <> '' then
                        "Montant Retenue DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date",
                        "Currency Code", "Montant Retenue", "Currency Factor")
                        , RecGCurrency."Amount Rounding Precision")
                    else
                        "Montant Retenue DS" := ROUND("Montant Retenue", RecGGeneralLedgerSetup."Amount Rounding Precision");
                end;
            end;
        }
        field(50051; "Montant Retenue Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50055; "Montant Retenue DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50056; "Montant Retenue Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50070; "Montant Retenue TVA"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                if ((Amount > 0) and ("Montant Retenue TVA" > 0)) or ((Amount < 0) and ("Montant Retenue TVA" < 0)) then
                    "Montant Retenue TVA" := -"Montant Retenue TVA";
            end;
        }
        field(50071; "Montant Retenue TVA Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50075; "Montant Retenue TVA DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50076; "Montant Retenue TVA Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50080; "Montant TVA sur Commission"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin

                if (((Amount > 0) and ("Montant TVA sur Commission" < 0)) or ((Amount < 0) and ("Montant TVA sur Commission" > 0)))
                  and ("Account Type" = "account type"::Vendor) then
                    "Montant TVA sur Commission" := -"Montant TVA sur Commission"
                else
                    if (((Amount > 0) and ("Montant TVA sur Commission" > 0)) or ((Amount < 0) and ("Montant TVA sur Commission" < 0)))
                      and ("Account Type" = "account type"::Customer) then
                        "Montant TVA sur Commission" := -"Montant TVA sur Commission";
            end;
        }
        field(50081; "Montant TVA sur Commission DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                if (((Amount > 0) and ("Montant TVA sur Commission DS" < 0)) or ((Amount < 0) and ("Montant TVA sur Commission DS" > 0)))
                  and ("Account Type" = "account type"::Vendor) then
                    "Montant TVA sur Commission DS" := -"Montant TVA sur Commission DS"
                else
                    if (((Amount > 0) and ("Montant TVA sur Commission DS" > 0)) or ((Amount < 0) and ("Montant TVA sur Commission DS" < 0)))
                      and ("Account Type" = "account type"::Customer) then
                        "Montant TVA sur Commission DS" := -"Montant TVA sur Commission DS";
            end;
        }
        field(50082; "Montant Commission"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                if (((Amount > 0) and ("Montant Commission" < 0)) or ((Amount < 0) and ("Montant Commission" > 0)))
                  and ("Account Type" = "account type"::Vendor) then
                    "Montant Commission" := -"Montant Commission"
                else
                    if (((Amount > 0) and ("Montant Commission" > 0)) or ((Amount < 0) and ("Montant Commission" < 0)))
                      and ("Account Type" = "account type"::Customer) then
                        "Montant Commission" := -"Montant Commission";
                "Montant TVA sur Commission" := 0;
                "Montant TVA sur Commission DS" := 0;
            end;
        }
        field(50083; "Montant Commission DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';

            trigger OnValidate()
            begin
                if (((Amount > 0) and ("Montant Commission DS" < 0)) or ((Amount < 0) and ("Montant Commission DS" > 0)))
                  and ("Account Type" = "account type"::Vendor) then
                    "Montant Commission DS" := -"Montant Commission DS"
                else
                    if (((Amount > 0) and ("Montant Commission DS" > 0)) or ((Amount < 0) and ("Montant Commission DS" < 0)))
                      and ("Account Type" = "account type"::Customer) then
                        "Montant Commission DS" := -"Montant Commission DS";
                "Montant TVA sur Commission" := 0;
                "Montant TVA sur Commission DS" := 0;
            end;
        }
        field(50090; "Montant TVA sur Com. validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50091; "Montant TVA sur Com. validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50092; "Montant Commission Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50093; "Montant Commission Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50094; "Validé Caisse"; Boolean)
        {
            Description = 'MH SORO 19-11-2016';
        }
        field(50095; "Type Origine"; Option)
        {
            Description = 'MH SORO 08-12-2016';
            OptionMembers = " ","Salarié",Client,Fournisseur,Divers;
            trigger OnValidate()
            begin
                Benificiaire := '';
                "Nom Benificiaire" := '';
            end;
        }
        field(50100; Commentaires; Text[250])
        {
            Description = 'SDT V1.00';
        }
        field(50101; "Montant Initial"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50102; "Montant Initial DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50103; "N° Paie"; Code[20])
        {
        }
        field(50104; "Description Paie"; Text[200])
        {
        }
        field(50105; Affect; Code[20])
        {
            // TableRelation = Section.Section;
        }
        field(50106; Qualification; Code[20])
        {
        }
        field(50107; "Designation Affectation"; Text[200])
        {
        }
        field(50108; "Designation Qualification"; Text[200])
        {
        }
        field(50109; "Numero Seq Retour"; Code[20])
        {
        }
        field(50110; MoisPaie; Option)
        {
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé";
        }
        field(50111; AnnePaie; Integer)
        {
        }
        field(50112; Receptionneur; Code[20])
        {
            TableRelation = Salarier;

            trigger OnValidate()
            begin
                RecSalarier.Reset;
                RecSalarier.SetRange(RecSalarier.Salarie, Receptionneur);
                if RecSalarier.FindFirst() then "Nom Receptionneur" := RecSalarier."Nom Et Prenom";
            end;
        }
        field(50113; "Nom Receptionneur"; Text[200])
        {
        }
        field(50114; Affaire; Code[20])
        {
            TableRelation = Job;
        }
        field(50115; Selectionner; Boolean)
        {
            Description = 'MH SORO 15-11-2017';
        }
        field(50116; "Integration Avance Fournisseur"; Boolean)
        {
            Description = 'MH SORO 15-11-2017';
        }
        field(50117; "Code Borderaux AV Fourn"; Code[20])
        {
            Description = 'MH SORO 15-11-2017';
        }
        field(50200; "Avance ouvert"; Boolean)
        {
            Description = 'SDT V1.00';
        }
        field(50201; "Montant Ouvert"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50202; "Montant Ouvert DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50300; "Job No."; Code[20])
        {
            Description = 'SDT V1.00';
        }
        field(50408; "Code Retenue de Garantie"; Code[10])
        {
            Description = 'SDT V1.00';
            // TableRelation = "Groupe Retenue".Code where("Type Retenue" = filter("de garantie"));

            trigger OnValidate()
            begin
                if ((Amount > 0) and ("Montant Retenue G." > 0)) or ((Amount < 0) and ("Montant Retenue G." < 0)) then
                    "Montant Retenue G." := -"Montant Retenue G.";

                // Calc Montant Retenue G.
                if "Currency Code" <> '' then RecGCurrency.Get("Currency Code");
                if ("Montant Retenue G." <> 0) and ("Montant Retenue G. Validé" = 0) and
                (RecGPaymentStatus."Calculer Retenue sur Garantie") then begin
                    if "Currency Code" <> '' then
                        "Montant Retenue G. DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date",
                        "Currency Code", "Montant Retenue G.", "Currency Factor")
                        , RecGCurrency."Amount Rounding Precision")
                    else
                        "Montant Retenue G. DS" := ROUND("Montant Retenue G.", RecGGeneralLedgerSetup."Amount Rounding Precision");
                end;
            end;
        }
        field(50450; "Montant Retenue G."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50451; "Montant Retenue G. Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50455; "Montant Retenue G. DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50456; "Montant Retenue G. Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50501; "N° Salarié"; Code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = Employee;
        }
        field(50502; "N° compte En tête"; Code[20])
        {
            CalcFormula = lookup("Payment Header"."Account No." where("No." = field("No.")));
            Caption = 'N° compte En tête';
            Description = '*';
            FieldClass = FlowField;
        }
        field(50507; "Référence chèque"; Code[20])
        {
            Description = 'MBK';
            Editable = false;
            TableRelation = "Référence Chèques";

            trigger OnLookup()
            var
                "Listréférencechèques_lf": page "List référence chèques";
                "RéférenceChèques_lr": Record "Référence Chèques";
                PaymentHeader_lr: Record "Payment Header";
                "Chèquemouvementé_lr": Record "Chèque mouvementé";
                Text0010: label 'Référence chèque non valide';
                Text0011: label 'Veuillez choisir le N° de compte';
            begin
                //>>>MBK:05/02/2010: Référence chèque
                if "Account No." = '' then
                    Error(Text0011);
                PaymentHeader_lr.Reset;
                if PaymentHeader_lr.Get("No.") then;
                Clear(Listréférencechèques_lf);
                RéférenceChèques_lr.SetRange("Code banque", PaymentHeader_lr."Account No.");
                Listréférencechèques_lf.SetTableview(RéférenceChèques_lr);
                Listréférencechèques_lf.SetRecord(RéférenceChèques_lr);
                if Listréférencechèques_lf.RunModal = Action::LookupOK then begin
                    Listréférencechèques_lf.GetRecord(RéférenceChèques_lr);
                    if RéférenceChèques_lr."Date début utilisation" <> 0D then
                        if PaymentHeader_lr."Posting Date" < RéférenceChèques_lr."Date début utilisation" then
                            Error(Text0010);
                    if RéférenceChèques_lr."Date fin utilisation" <> 0D then
                        if PaymentHeader_lr."Posting Date" > RéférenceChèques_lr."Date fin utilisation" then
                            Error(Text0010);
                    "Référence chèque" := RéférenceChèques_lr."Référence Chèques";
                end;
                Chèquemouvementé_lr.Reset;
                Chèquemouvementé_lr.SetRange(Chèquemouvementé_lr."Code banque", PaymentHeader_lr."Account No.");
                Chèquemouvementé_lr.SetRange("Référence chèque", "Référence chèque");
                Chèquemouvementé_lr.SetRange(Chèquemouvementé_lr.Statut, Chèquemouvementé_lr.Statut::" ");
                if Chèquemouvementé_lr.FindFirst then
                    Validate("N° chèque", Chèquemouvementé_lr."N°Chèque");
                //<<<MBK:05/02/2010: Référence chèque
            end;
        }
        field(50508; "N° chèque"; Integer)
        {
            Description = 'MBK';

            trigger OnValidate()
            var
                "RéférenceChèques_lr": Record "Référence Chèques";
                PaymentHeader_lr: Record "Payment Header";
                "Chèquemouvementé_lr": Record "Chèque mouvementé";
                Text001: label 'Numéro utilisé';
                Text002: label 'Numéro hors intervalle';
                Text003: label 'Numéro bloqué';
            begin
                //>>>MBK:05/02/2010: Référence chèque
                if ("N° chèque" <> 0) then begin
                    PaymentHeader_lr.Reset;
                    if PaymentHeader_lr.Get("No.") then;
                    if Chèquemouvementé_lr.Get(PaymentHeader_lr."Account No.", "Référence chèque", "N° chèque") then begin
                        if Chèquemouvementé_lr.Statut = Chèquemouvementé_lr.Statut::Bloquer then
                            Error(Text003);
                        if (Chèquemouvementé_lr.Statut <> Chèquemouvementé_lr.Statut::" ") and
                        (Chèquemouvementé_lr.Statut <> Chèquemouvementé_lr.Statut::Encours) then
                            Error(Text001);
                        Chèquemouvementé_lr.Statut := Chèquemouvementé_lr.Statut::Encours;
                        Chèquemouvementé_lr."N° Bordereu" := "No.";
                        Chèquemouvementé_lr.Modify;
                        Chèquemouvementé_lr."N° Ligne Bordereu" := "Line No.";
                        Chèquemouvementé_lr.Modify;
                    end;
                end;
                if "N° chèque" = 0 then LibererCheque;
                if RéférenceChèques_lr.Get(PaymentHeader_lr."Account No.", "Référence chèque") then
                    if ("N° chèque" < RéférenceChèques_lr."N° début") or ("N° chèque" > RéférenceChèques_lr."N° fin") then
                        Error(Text002);
                "External Document No." := Format("N° chèque");
                //<<<MBK:05/02/2010: Référence chèque
            end;
        }
        field(50509; "Code compte"; Code[20])
        {
            Description = 'AGA';
            TableRelation = if ("Type de compte" = const("G/L Account")) "G/L Account"
            else
            if ("Type de compte" = const(Customer)) Customer
            else
            if ("Type de compte" = const(Vendor)) Vendor
            else
            if ("Type de compte" = const("Bank Account")) "Bank Account"
            else
            if ("Type de compte" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Type de compte" = const("Frais annexe")) "Item Charge"
            ELSE IF ("Type de compte" = CONST(Salarier)) Salarier;

            trigger OnValidate()
            var
                RecItemCharge: Record "Item Charge";
                RecGeneralPostingSetup: Record "General Posting Setup";
                TEXT001: label 'Vous devez spécifier le compte achat dans le groupe compta produit ';
                TEXT002: label 'groupe compta marché';
                LPaymenHeader: Record "Payment Header";
            begin
                //AGA 18/05/2010
                //UpdateEntry(false);
                case "Type de compte" of

                    0:
                        begin
                            "Account Type" := 0;
                            "Account No." := "Code compte";
                            Validate("Account No.");
                        end;
                    1:
                        begin
                            "Account Type" := 1;
                            "Account No." := "Code compte";
                            Validate("Account No.");

                        end;
                    2:
                        begin
                            "Account Type" := 2;
                            "Account No." := "Code compte";
                            Validate("Account No.");

                        end;
                    3:
                        begin
                            "Account Type" := 3;
                            "Account No." := "Code compte";
                            Validate("Account No.");

                        end;
                    4:
                        begin
                            "Account Type" := 4;
                            "Account No." := "Code compte";
                            Validate("Account No.");

                        end;
                    5:
                        begin
                            RecItemCharge.SetFilter("No.", "Code compte");
                            if RecItemCharge.Find('-') then begin
                                "Account Type" := 0;
                                if RecItemCharge."Gen. Prod. Posting Group" = '' then
                                    Error('Vous devez spécifier le groupe compta produit ');
                                RecGeneralPostingSetup.SetFilter("Gen. Prod. Posting Group", RecItemCharge."Gen. Prod. Posting Group");

                                if RecGeneralPostingSetup.Find('-') then
                                    if RecGeneralPostingSetup."Purch. Account" <> '' then
                                        "Account No." := RecGeneralPostingSetup."Purch. Account"
                                    else
                                        Error(TEXT001 + RecItemCharge."Gen. Prod. Posting Group" + ' ' + TEXT002);
                                Validate("Account No.");


                            end;


                        end;
                end;
                // >> HJ DSFT 09-02-2014
                if "Due Date" <> 0D then begin
                    "Annee Echeance" := Date2dmy("Due Date", 3);
                    "Mois Echeance" := Date2dmy("Due Date", 2);
                END;
                IF RecPaymentHeader.GET("No.") THEN RecPaymentHeader.TESTFIELD("Account No.");
                IF PaymentClass.GET("Payment Class") THEN;
                IF ("Line No." = 1000) AND (PaymentClass."Credit Bancaire Avec Echeancie")
                  THEN
                    "Type Ligne Credit" := 1;
                // >> HJ DSFT 09-02-2014

                //<< AGA 18/05/2010
            end;
        }
        field(50510; "Type de compte"; Option)
        {
            Description = 'AGA';
            OptionCaption = 'Général,Client,Fournisseur,Banque,Immobilisation,Frais annexe,Salarier';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","Frais annexe",Salarier;

            trigger OnLookup()
            var
                LPaymenHeader: Record "Payment Header";
            begin
            end;

            trigger OnValidate()
            begin
                //UpdateEntry(false);
                "Account No." := '';
                "Code compte" := '';
            end;
        }
        field(50511; Agence; Code[20])
        {
            Description = 'HJ DSFT 09 12 2010';
        }
        field(50512; Utilisateur; Code[50])
        {
            Description = 'HJ DSFT 09 12 2010';
        }
        field(50513; "Jours Restants"; Integer)
        {
            Description = 'MBK';
        }
        field(50514; "Intérêt FED"; Decimal)
        {
            Description = 'IMS 11 05 2011';

            trigger OnValidate()
            begin
                if "Currency Code" <> '' then
                    "Intérêt FED (DS)" := "Intérêt FED" / "Currency Factor";
            end;
        }
        field(50515; "Intérêt FED (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 11 05 2011';
        }
        field(50516; "Intérêt Escompte"; Decimal)
        {
            Description = 'IMS 11 05 2011';

            trigger OnValidate()
            begin
                if "Currency Code" <> '' then
                    "Intérêt Escompte (DS)" := "Intérêt Escompte" / "Currency Factor";
            end;
        }
        field(50517; "Intérêt Escompte (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 11 05 2011';
        }
        field(50518; "Intérêt FED Validé"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50519; "Intérêt FED (DS) validé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 11 05 2011';
        }
        field(50520; "Intérêt Escompte validé"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50521; "Intérêt Escompte (DS) validé"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50522; "Intérêt sur Prêt"; Decimal)
        {
            Description = 'IMS 02 06 2011';

            trigger OnValidate()
            begin
                if "Currency Code" <> '' then
                    "Intérêt sur Prêt (DS)" := "Intérêt sur Prêt" / "Currency Factor";
            end;
        }
        field(50523; "Intérêt sur Prêt (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 02 06 2011';
        }
        field(50524; "Intérêt sur Prêt Validé"; Decimal)
        {
            Description = 'IMS 02 06 2011';
        }
        field(50525; "Intérêt sur Prêt (DS) validé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 02 06 2011';
        }
        field(50526; EX; Boolean)
        {

        }
        field(50527; "Motif Depense Ex"; Code[20])
        {
            Description = 'HJ DSFT 06-02-2014';
            // TableRelation = "Motif Depense Ext";

            trigger OnValidate()
            begin
                // IF MotifDepenseExt.GET("Motif Depense Ex") THEN BEGIN
                //     Provisoire := MotifDepenseExt.Provisoire;
                //     Alimentation := MotifDepenseExt."Alimentation Caisse";
                // END;
            END;


        }
        field(50528; "Mois Echeance"; Integer)
        {
            Description = 'HJ DSFT 06-02-2014';
        }
        field(50529; "Annee Echeance"; Integer)
        {
            Description = 'HJ DSFT 06-02-2014';
        }
        field(50530; "Marché"; Code[20])
        {
            Description = 'HJ DELTA 09-02-2014';
            TableRelation = Job;
        }
        field(50531; "Opération"; Option)
        {
            Description = 'HJ DELTA 09-02-2014';
            OptionMembers = "Contrôles Factures",Appro,Technique;
        }
        field(50532; "Type Ligne Credit"; Option)
        {
            Description = 'HJ DELTA 09-02-2014';
            Editable = false;
            OptionMembers = " ",Emis,Principal,Interet;
        }
        field(50533; "Comptabilisé"; Boolean)
        {
            Description = 'HJ DELTA 09-02-2014';
            Editable = false;
        }
        field(50534; Historique; Boolean)
        {
            Description = 'HJ DELTA 09-02-2014';
            Editable = false;
        }
        field(50535; "Numero Seq"; Integer)
        {
            Description = 'HJ DELTA 09-02-2014';
        }
        field(50536; Caisse; Boolean)
        {
            Description = 'HJ DELTA 09-02-2014';
        }
        field(50537; Benificiaire; Code[30])
        {
            Description = 'HJ DELTA 09-02-2014';
            TableRelation = Salarier;

            /*  trigger OnValidate()
              begin
                  if "Type Origine" = 4 then begin
                      RecSalarier.Reset;
              RecSalarier.SetRange(RecSalarier.Salarie, Benificiaire);
              if RecSalarier.FindFirst() then begin
                          "Nom Benificiaire" := RecSalarier."Nom Et Prenom";
              if RecEmployee.Get(Benificiaire) then begin
                              if RecAffectation.Get(RecEmployee.Affectation) then Affaire := RecAffectation.Chantier;
                          end
                      end
                  end;

                  if "Type Origine" = 2 then begin
                      RecCustomer.Reset;
                      RecCustomer.SetRange(RecCustomer."No.", Benificiaire);
                      if RecCustomer.FindFirst() then "Nom Benificiaire" := RecCustomer.Name;
                  end;

                  if "Type Origine" = 3 then begin
                      RecVendor.Reset;
                      RecVendor.SetRange(RecVendor."No.", Benificiaire);
                      if RecVendor.FindFirst() then "Nom Benificiaire" := RecVendor.Name;
                  end;
                  if "Type Origine" = 1 then begin
                      RecEmployee.Reset;
                      RecEmployee.SetRange(RecEmployee."No.", Benificiaire);
                      if RecEmployee.FindFirst() then "Nom Benificiaire" := RecEmployee."First Name";
                  end;
              end;*/
        }
        field(50538; "Provisoire"; Boolean)
        {
            Description = 'HJ SORO 12-09-2014 : A:Alimentation, E : Ext, C : Cpt';

        }
        field(50539; "Caisse Chantier"; Boolean)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50634; "Caisse Destination"; Code[20])
        {

            caption = 'Caisse Destination';
            TableRelation = "Payment Header";
        }
        field(50540; "Alimentation"; Boolean)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50541; "Envoyé Vers"; code[20])
        {
            Description = 'HJ SORO 12-09-2014 RB SORO 26/03/2015';
        }
        field(50542; "N° Origine"; code[20])
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50543; "Ligne Origine"; Integer)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50545; Brouillard; Boolean)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50546; Journal; Boolean)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50547; "Date Debut"; Date)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50548; "Date Fin"; Date)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50549; Tranche; Decimal)
        {
            Description = 'HJ SORO 12-09-2014';
        }
        field(50550; "Nom Benificiaire"; Text[50])
        {
            Description = 'HJ SORO 12-09-2014';
            Editable = true;
        }
        field(50551; "Mois Concerné"; Option)
        {
            Description = 'HJ SORO 12-09-2014';
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Setembre,Octobre,Novembre,Decembre;
        }
        field(50552; "Pris en charge"; Code[20])
        {
            Description = 'HJ SORO 14-10-2014';
        }
        field(50553; "Nom Pris En Charge"; Text[50])
        {
            Description = 'HJ SORO 14-10-2014';
        }
        field(50554; "Mode Paiement"; Option)
        {
            Description = 'HJ SORO 22-12-2014';
            OptionMembers = " ",Cheque,Traite,Espece,Virement;

            /*  trigger OnValidate()
              var
                  LPaymentClass: Record "Payment Class";
              begin
                  if "Payment Class" = 'PAIEMENT' then begin
                      if "Mode Paiement" = "mode paiement"::Cheque then
                          if LPaymentClass.Get('DECAISS-CHEQUE') then
                              "Affectation Financiere" := LPaymentClass."Affectation Financier";

                      if "Mode Paiement" = "mode paiement"::Traite then
                          if LPaymentClass.Get('DECAISS-TRAITE') then
                              "Affectation Financiere" := LPaymentClass."Affectation Financier";
                  end;
              end;*/
        }
        field(50555; "Compte Bancaire"; Code[20])
        {
            Description = 'HJ SORO 22-12-2014';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                //    if RecGBankAccount.Get("Compte Bancaire") then
                //   Banque := RecGBankAccount.Banque;
            end;
        }
        field(50556; "Commande N°"; Code[20])
        {
            Description = 'HJ SORO 22-12-2014';
        }
        field(50557; Chantier; Code[20])
        {
            Description = 'HJ SORO 22-12-2014';
            // TableRelation = "Chantier Loyer";
        }
        field(50558; Proprietaire; Code[20])
        {
            Description = 'HJ SORO 22-12-2014';
        }
        field(50559; Deduction; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 22-12-2014';

            trigger OnValidate()
            begin
                MontantInitial := "Montant Initial";
                if Deduction < "Montant Initial" then
                    Validate("Debit Amount", "Montant Initial" - Deduction);
                "Montant Initial" := MontantInitial;
            end;
        }
        field(50560; Imprimer; Text[1])
        {
            Description = 'HJ SORO 29-01-2015';
        }
        field(50561; Banque; Option)
        {
            Description = 'HJ SORO 03-02-2015';
            OptionMembers = " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA,BIAT,STUSID,TSB,"WIFAK BANK","ALBARAKA BANK";
        }
        field(50562; "Ancien Num Reglement"; Code[20])
        {
            Description = 'HJ SORO 05-02-2015';
        }
        field(50563; "Date Loyer"; Date)
        {
            Description = 'HJ SORO 05-02-2015';
            Editable = true;
        }
        field(50564; Appartement; Code[10])
        {
            Description = 'HJ SORO 05-02-2015';
        }
        /*  field(50565; "Folio N°"; Code[20])
          {
              CalcFormula = lookup("G/L Entry"."Folio N°" where("Source Type" = const("Bank Account"),
                                                                 "Folio N°" = filter(<> ''),
                                                                 "Document No." = field("No.")));
              Description = 'HJ SORO 24-02-2015';
              Editable = false;
              FieldClass = FlowField;
          }*/
        field(50566; "Folio N° RS"; Code[20])
        {
            Description = 'RB SORO 27/04/2015';
        }
        field(50567; "Certif Ret. Imprimer"; Boolean)
        {
            Description = 'RB SORO 27/04/2015';
        }
        field(50568; "Ordre Paiement Imprimer"; Boolean)
        {
            Description = 'RB SORO 27/04/2015';
        }
        field(50569; "N° Contrat"; Code[20])
        {
            Description = 'HJ SORO 20-06-2015';
        }
        field(50570; "N° Ligen Contrat"; Integer)
        {
            Description = 'HJ SORO 20-06-2015';
        }
        field(50571; "Folio BOR"; Code[20])
        {
            Description = 'HJ SORO 07-07-2015';
            Editable = false;
        }
        field(50572; Affectation; Code[20])
        {
            //  CalcFormula = lookup("Payment Header".Affectation where("No." = field("No.")));
            Description = 'RB SORO 31/08/2015';
            // FieldClass = FlowField;
        }
        field(50573; "Salarié"; Code[20])
        {
            Description = 'HJ SORO 08-03-2016';
            TableRelation = Salarier;
        }
        field(50574; "Libelle Statut"; Text[50])
        {
            Description = 'HJ SORO 21-06-2016';
        }
        field(50575; "Montant Avance/Pret"; Decimal)
        {
            Description = 'RB SORO 03/01/2017';
        }
        field(50576; "Affectation Financiere"; Code[60])
        {
            Description = 'HJ SORO 24-02-2017';
            //TableRelation = "Affectation Opération Bancaire";
        }
        field(50577; "Type Remise"; Option)
        {
            OptionMembers = " ","A l'escompte","a l'encaissement";
        }
        field(50578; "Affectation Client"; Code[20])
        {
            Description = 'RB SORO 13/07/2017';
            TableRelation = Customer."No.";
        }
        field(50579; "Nom Client"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Affectation Client")));
            Description = 'RB SORO 13/07/2017';
            FieldClass = FlowField;
        }
        field(50580; "Facture N°"; Code[20])
        {
            Description = 'RB SORO 07/09/2017';
        }
        /*  field(50581; "Caisse Chantier"; Boolean)
          {
              Description = 'HJ SORO 12-03-2018';
          }*/
        field(50582; Motif; Text[250])
        {
            Description = 'MH SORO 14-07-2020';
        }
        field(50583; "N° Affaire"; Code[20])
        {
            Description = 'MH SORO 20-04-2021';
            TableRelation = Job;
        }
        field(51000; "Agency Code soroubat"; Text[20])
        {
            Caption = 'Agency Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // "RIB Checked" := RibKey.Check("Bank Branch No.","Agency Code","Bank Account No.","RIB Key");
            end;
        }
        field(51001; "Drawee Reference soroubat"; Text[50])
        {
            Caption = 'Drawee Reference';
            DataClassification = ToBeClassified;
        }

        /*  field(51002; "Filtre No. Affaire"; CODE[20])
          {
              Caption = 'Filtre N° Affaire';
              DataClassification = ToBeClassified;
          }*/
    }
    keys
    {

        /*GL2024   key(Key2;"Copied To No.","Copied To Line",Caisse)
            {
            }

            key(Key6;"Header Account Type","Header Account No.","No.","Line No.","Copied To No.","Copied To Line")
            {
            SumIndexFields = "Amount (LCY)";
            }

            key(Key7;"Account Type","Account No.","Avance Valider")
            {
            SumIndexFields = "Amount (LCY)";
            }
    */
        key(Key8; "Payment in Progress", "Status No.", "Account Type", "Account No.", "Payment Class", "Posting Date", IsCopy)
        {
            SumIndexFields = "Amount (LCY)";
        }

        key(Key9; "Payment Class", "Account Type", "Status No.", "No.")
        {
            SumIndexFields = "Amount (LCY)";
        }

        key(Key10; "Copied To Line", "Status No.", "Payment Class", "Account No.")
        {
            SumIndexFields = "Amount (LCY)";
        }

        key(Key11; "Copied To No.", "Status No.", "Payment Class", "Account No.", "Payment in Progress", "Account Type")
        {
            SumIndexFields = "Amount (LCY)";
        }

        key(Key12; "Account No.", "Account Type", "Status No.", "Payment in Progress", "Due Date", "Copied To No.", "Copied To Line", "Payment Class")
        {
            SumIndexFields = "Amount (LCY)";
        }

        key(Key13; "Account No.", "Account Type", "Payment in Progress", "Due Date")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }

        key(Key14; "Payment in Progress", "Account No.", "Account Type", "Payment Class", "Due Date")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }

        key(Key15; "No.", "Copied To No.", "Copied To Line", "Line No.")
        {
        }

        key(Key16; "Due Date", "Document No.")
        {
        }

        key(Key17; "Copied To No.", "Status No.", "Payment Class", "Account Type", "Account No.")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }

        key(Key18; "Copied To Line", "Copied To No.", "Payment in Progress", "Account Type", "Account No.", "Payment Class")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }

        key(Key19; "Applies-to Doc. No.", "Account Type", "Account No.")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }

        /*GL2024    key(Key20;"Payment Class","Account Type","Groupe Comptabilisation","Posting Date",Amount)
            {
            SumIndexFields = "Amount (LCY)",Amount;
            }

            key(Key21;"Type paiement","Copied To No.","Status No.","Payment in Progress","Account Type","Account No.","N° commande")
            {
            SumIndexFields = "Amount (LCY)",Amount;
            }
      */
        key(Key22; "Account No.", "Due Date")
        {
        }

        key(Key23; Amount, "No.")
        {
        }
        key(Key24; "Code Retenue à la Source")
        {
        }

        /* GL2024   key(Key25; "Payment Class", "Code Retenue à la Source")
            {
            }
    */
        key(Key26; "Due Date")
        {
        }

        key(Key27; "Copied To No.", "Account No.", "Account Type", "Status No.", "Payment Class", "Due Date")
        {
            SumIndexFields = Amount;
        }

        key(Key28; "Payment Class", "Due Date")
        {
        }

        /*GL2024  key(Key29; "Code Retenue à la Source", "Payment Class")
          {
          }

          key(Key30; "Payment Class", "Annee Echeance", "Mois Echeance")
          {
          }*/
        key(Key31; Caisse, "Caisse Chantier", "N° Affaire")
        {
            //GL2024 SumIndexFields = Amount;
        }
        // key(Key32; "Code Opération", Benificiaire)
        // {
        // }
        key(Key33; Banque, "Compte Bancaire")
        {
        }

        /*  GL2024   key(Key34; "Account No.", Appartement, "Date Loyer")
             {
             }

             key(Key35; "Due Date", Banque)
             {
             }*/

        key(Key36; "Copied To No.", "Acc. No. Last Entry Debit", "Account No.", "Payment Class", "Status No.")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }
        key(Key37; "N° Decharge")
        {
        }

        /*GL2024  key(Key38; "Code Opération", "Due Date", Benificiaire, Amount)
          {
          }

          key(Key39; Affect, "Code Opération", "Due Date", Benificiaire, Amount)
          {
          }

          key(Key40; Benificiaire, "Due Date", "Document No.", "Code Opération", Amount)
          {
          }*/
    }


    trigger OnAfterInsert()
    var
        Statement: Record "Payment Header";
    begin
        Statement.Get("No.");
        //>> HJ DSFT 09 12 2010
        Agence := Statement.Agence;
        Utilisateur := Statement.Utilisateur;

        IF "Payment Class" = 'DECAISS-TRAITE-AVAL' THEN Aval := TRUE;

        //>> HJ DSFT 09 12 2010
        // STD V2.00
        IF "Currency Code" <> '' THEN
            RecGCurrency.GET("Currency Code");

        RecGPaymentStatus.RESET;
        RecGPaymentStatus.SETRANGE("Payment Class", "Payment Class");
        RecGPaymentStatus.SETRANGE(Line, "Status No.");
        RecGPaymentStatus.SETFILTER(Annulation, 'Oui');
        IF RecGPaymentStatus.FIND('-') THEN
            Annulation := TRUE;
        // STD V2.00
    end;

    trigger OnAfterDelete()
    var
        LoanAdvanceHeader: Record "Loan & Advance Header";
        LoanAdvanceLines: Record "Loan & Advance Lines";
    begin
        //>> HJ DSFT 11 11 2010
        LibererCheque;
        //>> HJ DSFT 11 11 2010
        // RB SORO 07/02/2017 SUITE A L'INTEGRATION DE LA CAISSE EN COMPTABILITE
        /*  IF "Payment Class" = 'PAIECAISSE' THEN BEGIN
              RecPaymentLineCaisse.SETRANGE(Chrono, "No.");
              IF RecPaymentLineCaisse.FINDFIRST THEN
                  REPEAT
                      RecPaymentLineCaisse.Chrono := '';
                      RecPaymentLineCaisse.MODIFY;
                  UNTIL RecPaymentLineCaisse.NEXT = 0;
          END;
          // RB SORO 07/02/2017
          // RB SORO 12/07/2017 SUITE A L'INTEGRATION DE LOT DE PAIE EN COMPTABILITE
          RecEnteteLotPaie.RESET;
          IF "Payment Class" = 'VIR-SALAIRE' THEN BEGIN
              RecEnteteLotPaie.SETRANGE("Code Bordereau", "No.");
              IF RecEnteteLotPaie.FINDFIRST THEN BEGIN
                  RecEnteteLotPaie."Code Bordereau" := '';
                  RecEnteteLotPaie.MODIFY;
              END;
          END;
          // RB SORO 12/07/2017
          // RB SORO 06/09/2017 SUITE A L'INTEGRATION DE REJET DE SALAIRE EN COMPTABILITE
          RecEnteteLotPaie.RESET;
          IF "Payment Class" = 'REJET-SALAIRE' THEN BEGIN
              RecEnteteLotPaie.SETRANGE("Code Bordereau", "No.");
              IF RecEnteteLotPaie.FINDFIRST THEN BEGIN
                  RecEnteteLotPaie."Code Bordereau" := '';
                  RecEnteteLotPaie.MODIFY;
              END;
          END;*/
        // RB SORO 06/09/2017
        // >> HJ SORO 04-07-2017
        /*    {IF ("Numero Seq" <> '') AND (Benificiaire <> '') THEN BEGIN
         LoanAdvanceHeader.SETRANGE("Nø Bon Caisse", "Numero Seq");
         IF LoanAdvanceHeader.FINDFIRST THEN BEGIN
             LoanAdvanceLines.SETRANGE("No.", LoanAdvanceHeader."No.");
             LoanAdvanceLines.DELETEALL;
             LoanAdvanceHeader.DELETE;
         END;

     END;}*/
        // >> HJ SORO 04-07-2017
    end;


    procedure CalcRetenu()
    var
        //  GroupeRetenu: Record "Groupe Retenue";
        StepT: Record "Payment Step Ledger";
    begin
        //*** HK DSFT
        //VALIDATE("Montant Retenue Validé","Montant Retenue");
        // VALIDATE("Montant Retenue Validé DS","Montant Retenue DS");
        //*** HK DSFT
        Clear(RecGPaymentStatus1);
        RecGPaymentStatus1.Reset;
        Clear(RecGCustomer);
        RecGCustomer.Reset;
        Clear(RecGVendor);
        RecGVendor.Reset;
        Clear(RecGGeneralLedgerSetup);
        RecGGeneralLedgerSetup.Reset;
        RecGGeneralLedgerSetup.Get;
        Clear(RecGCurrency1);
        RecGCurrency1.Reset;
        if "Currency Code" <> '' then RecGCurrency1.Get("Currency Code");
        Clear(RecGPaymentStepLedger);
        RecGPaymentStepLedger.Reset;
        RecGPaymentStepLedger.SetFilter("Payment Class", "Payment Class");
        RecGPaymentStepLedger.SetRange("Inclure Commission", true);
        RecGPaymentStepLedger.SetFilter("% TVA", '<>0');
        if (RecGPaymentStepLedger.Find('-')) and (("Montant TVA sur Commission" = 0) and ("Montant TVA sur Commission DS" = 0)) then begin
            if "Montant Commission DS" <> 0 then begin
                "Montant TVA sur Commission DS" := ROUND("Montant Commission DS" * RecGPaymentStepLedger."% TVA" / 100,
                RecGGeneralLedgerSetup."Amount Rounding Precision");
                "Montant Commission DS" := "Montant Commission DS" - "Montant TVA sur Commission DS";
            end else
                if "Montant Commission" <> 0 then begin
                    if "Currency Code" <> '' then
                        "Montant TVA sur Commission" := ROUND("Montant Commission" *
                        RecGPaymentStepLedger."% TVA" / 100, RecGCurrency1."Amount Rounding Precision")
                    else
                        "Montant TVA sur Commission" := ROUND("Montant Commission" * RecGPaymentStepLedger."% TVA" / 100,
                        RecGGeneralLedgerSetup."Amount Rounding Precision");

                    "Montant Commission" := "Montant Commission" - "Montant TVA sur Commission";
                end;
        end;


        "VarD%Retenue" := 0;
        /*  Clear(GroupeRetenu);
          GroupeRetenu.Reset;
          if GroupeRetenu.Get(0, "Code Retenue à la Source") then;
          "VarD%Retenue" := GroupeRetenu."% Retenue";*/
        if "Montant Retenue DS" = 0 then
            "Montant Retenue DS" := -ROUND("Montant Initial DS" * ("VarD%Retenue" / 100),
            RecGGeneralLedgerSetup."Amount Rounding Precision");

        if RecGPaymentStatus1.Get("Payment Class", "Status No.") then
            if ("Montant Retenue" = 0) and ("Montant Retenue Validé" = 0) and (RecGPaymentStatus1."Calculer Retenue à la source") then begin
                //   "VarD%Retenue" := GroupeRetenu."% Retenue";
                if "Currency Code" <> '' then
                    "Montant Retenue" := -ROUND("Montant Initial" * ("VarD%Retenue" / 100), RecGCurrency1."Amount Rounding Precision")
                else
                    "Montant Retenue" := -ROUND("Montant Initial" * ("VarD%Retenue" / 100),
                    RecGGeneralLedgerSetup."Amount Rounding Precision");
                "Montant Retenue DS" := -ROUND("Montant Initial DS" * ("VarD%Retenue" / 100),
                RecGGeneralLedgerSetup."Amount Rounding Precision");
                CalcAmount;
                //VALIDATE(Amount,"Montant Initial"+"Montant Retenu"+"Montant Retenu TVA");
            end;

        //*** HK DSFT<< Calculer Retenu de Garentie.
        "VarD%Retenue" := 0;
        /*  Clear(GroupeRetenu);
          RecGPaymentStatus1.Reset;
          GroupeRetenu.Reset;
          if GroupeRetenu.Get(1, "Code Retenue de Garantie") then;
          "VarD%Retenue" := GroupeRetenu."% Retenue";*/
        if RecGPaymentStatus1.Get("Payment Class", "Status No.") then
            if ("Montant Retenue G." = 0) and ("Montant Retenue G. Validé" = 0) and
               (RecGPaymentStatus."Calculer Retenue sur Garantie") then begin
                //  "VarD%Retenue" := GroupeRetenu."% Retenue";
                if "Currency Code" <> '' then
                    "Montant Retenue G." := -ROUND("Montant Initial" * ("VarD%Retenue" / 100), RecGCurrency1."Amount Rounding Precision")
                else
                    "Montant Retenue G." := -ROUND("Montant Initial" * ("VarD%Retenue" / 100),
                    RecGGeneralLedgerSetup."Amount Rounding Precision");
                CalcAmount;
            end;

        //*** HK DSFT<<
    end;

    procedure UpdateFactor()
    begin
        if ("Copied To No." = '') and ("Copied To Line" = 0) then begin
            "Amount (LCY)" := RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor");
            "Montant Retenue DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Montant Retenue", "Currency Factor");

            "Montant Retenue Validé DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Montant Retenue Validé", "Currency Factor");
            "Montant Retenue TVA DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Montant Retenue TVA", "Currency Factor");
            "Montant Retenue TVA Validé DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Montant Retenue TVA Validé", "Currency Factor");
            "Montant TVA sur Commission" :=
            RecGCurrencyExchangeRate.ExchangeAmtLCYToFCY("Posting Date", "Currency Code",
            "Montant TVA sur Commission DS", "Currency Factor");
            "Montant Initial DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Montant Initial", "Currency Factor");
            "Montant Commission" :=
            RecGCurrencyExchangeRate.ExchangeAmtLCYToFCY("Posting Date", "Currency Code", "Montant Commission DS", "Currency Factor");

            Modify;
        end;
    end;

    local procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := WorkDate;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 1;
    end;

    local procedure ConfirmUpdateCurrencyFactor()
    begin
        "Currency Factor" := xRec."Currency Factor";
    end;


    procedure FractionnerLine()
    var
        RecT: Record "Payment Line";
        Wind: Dialog;
        Montantdef: Decimal;
        RecTmp: Record "Payment Line";
        Mntinit: Decimal;
        MntinitDS: Decimal;
        IntegerDialog: Page "Dialog fractionner ligne";
    begin
        if not (("Copied To No." = '') and ("Copied To Line" = 0)) then
            exit;

        Montantdef := 0;
        if not Confirm(StrSubstNo('Vous allez fractionné la ligne %1  %2  %3', "Line No.", "Account No.", Amount), false, true) then
            exit;
        Wind.Open('Montant a fractionner #1############## ');
        //GL2024    
        IntegerDialog.SetMontantFractionner(Montantdef);
        if IntegerDialog.RunModal() = Action::OK then
            Montantdef := IntegerDialog.GetMontantFractionner();
        //GL2024


        //DYS a verifier
        //   Wind.INPUT(1, Montantdef);



        if Montantdef = 0 then
            exit;
        Clear(RecTmp);
        RecTmp.Reset;
        RecTmp.SetFilter("No.", '=%1', "No.");
        RecT := Rec;
        RecTmp.SetFilter("Line No.", '%1..', "Line No." + 1);
        if RecTmp.Find('-') then
            RecT."Line No." := "Line No." + ((RecTmp."Line No." - "Line No.") / 2)
        else
            RecT."Line No." := "Line No." + 10000;
        if Amount > 0 then
            RecT.Validate(Amount, Montantdef)
        else
            RecT.Validate(Amount, -Montantdef);
        RecT."Montant Initial" := RecT.Amount;
        RecT."Montant Initial DS" := RecT."Amount (LCY)";
        RecT."Montant Retenue" := 0;
        RecT."Montant Retenue Validé" := 0;
        RecT."Montant Retenue DS" := 0;
        RecT."Montant Retenue Validé DS" := 0;
        RecT."Montant Retenue TVA" := 0;
        RecT."Montant Retenue TVA Validé" := 0;
        RecT."Montant Retenue TVA DS" := 0;
        RecT."Montant Retenue TVA Validé DS" := 0;
        RecT."Montant TVA sur Commission" := 0;
        RecT."Montant TVA sur Commission DS" := 0;
        RecT."Montant Commission" := 0;
        RecT."Montant Commission DS" := 0;
        RecT."Montant TVA sur Com. validé" := 0;
        RecT."Montant TVA sur Com. validé DS" := 0;
        RecT."Montant Commission Validé" := 0;
        RecT."Montant Commission Validé DS" := 0;
        RecT."Montant Retenue G." := 0;
        RecT."Montant Retenue G. Validé" := 0;
        RecT."Montant Retenue G. DS" := 0;
        RecT."Montant Retenue G. Validé DS" := 0;
        if RecT.Insert then begin
            Mntinit := "Montant Initial";
            MntinitDS := "Montant Initial DS";
            if Amount > 0 then
                Validate(Amount, Amount - Montantdef)
            else
                Validate(Amount, Amount + Montantdef);
            "Montant Initial" := Mntinit - RecT.Amount;
            "Montant Initial DS" := MntinitDS - RecT."Amount (LCY)";
            Modify;
        end;
        Wind.Close;
    end;

    procedure CalcAmount()
    begin
        Clear(RecGPaymentStatus1);
        RecGPaymentStatus1.Reset;
        MntRetenu := 0;
        MntRGart := 0;
        MntRet := 0;
        MntTva := 0;
        MntComm := 0;
        MntTvaComm := 0;
        if RecGPaymentStatus1.Get("Payment Class", "Status No.") then;
        // Retenu sur TVA
        Clear(RecGGeneralLedgerSetup);
        RecGGeneralLedgerSetup.Reset;
        RecGGeneralLedgerSetup.Get;
        Clear(RecGCurrency1);
        RecGCurrency1.Reset;
        // Calcul Montant Retenu TVA DS
        if "Currency Code" <> '' then RecGCurrency1.Get("Currency Code");
        if ("Montant Retenue TVA" <> 0) and ("Montant Retenue TVA Validé" = 0) and (RecGPaymentStatus1."Calculer Retenue Sur TVA") then begin
            if "Currency Code" <> '' then
                "Montant Retenue TVA DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY
                ("Posting Date", "Currency Code", "Montant Retenue TVA",
        "Currency Factor")
                , RecGCurrency1."Amount Rounding Precision")
            else
                "Montant Retenue TVA DS" := ROUND("Montant Retenue TVA", RecGGeneralLedgerSetup."Amount Rounding Precision");
        end;

        // Calcul Montant Commission DS
        if "Currency Code" <> '' then RecGCurrency1.Get("Currency Code");
        if ("Montant Commission DS" <> 0) and ("Montant Commission Validé" = 0) and (RecGPaymentStatus1.Commission) then begin
            if "Currency Code" <> '' then
                "Montant Commission" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtLCYToFCY("Posting Date",
                "Currency Code", "Montant Commission DS",
                "Currency Factor"), RecGCurrency1."Amount Rounding Precision")
            else
                "Montant Commission" := ROUND("Montant Commission DS", RecGGeneralLedgerSetup."Amount Rounding Precision");
        end else
            if ("Montant Commission" <> 0) and ("Montant Commission Validé" = 0) and (RecGPaymentStatus1.Commission) then begin
                if "Currency Code" <> '' then
                    "Montant Commission DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date",
                    "Currency Code", "Montant Commission",
                    "Currency Factor"), RecGCurrency1."Amount Rounding Precision")
                else
                    "Montant Commission DS" := ROUND("Montant Commission", RecGGeneralLedgerSetup."Amount Rounding Precision");
            end;

        // Calcul Montant TVA sur Commission DS
        if "Currency Code" <> '' then RecGCurrency1.Get("Currency Code");
        if ("Montant TVA sur Commission DS" <> 0) and ("Montant TVA sur Com. validé" = 0) and
        (RecGPaymentStatus1."Tva Sur Commission") then begin
            if "Currency Code" <> '' then
                "Montant TVA sur Commission" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtLCYToFCY("Posting Date",
                "Currency Code", "Montant TVA sur Commission DS",
                "Currency Factor"), RecGCurrency1."Amount Rounding Precision") //*** HK DSFT
            else
                "Montant TVA sur Commission" := ROUND("Montant TVA sur Commission DS", RecGGeneralLedgerSetup."Amount Rounding Precision");
        end else
            if ("Montant TVA sur Commission" <> 0) and ("Montant TVA sur Com. validé" = 0) and
            (RecGPaymentStatus1."Tva Sur Commission") then begin
                if "Currency Code" <> '' then
                    "Montant TVA sur Commission DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date",
                    "Currency Code", "Montant TVA sur Commission",
                    "Currency Factor"), RecGCurrency1."Amount Rounding Precision")
                else
                    "Montant TVA sur Commission DS" := ROUND("Montant TVA sur Commission", RecGGeneralLedgerSetup."Amount Rounding Precision");
            end;
        // Calcul Retenu sur Garantie
        if "Currency Code" <> '' then RecGCurrency1.Get("Currency Code");
        if ("Montant Retenue G. DS" <> 0) and ("Montant Retenue G. Validé" = 0) and
        (RecGPaymentStatus1."Calculer Retenue sur Garantie") then begin
            if "Currency Code" <> '' then
                "Montant Retenue G." := ROUND(RecGCurrencyExchangeRate.ExchangeAmtLCYToFCY("Posting Date",
                "Currency Code", "Montant Retenue G. DS",
                "Currency Factor"), RecGCurrency1."Amount Rounding Precision")
            else
                "Montant Retenue G." := ROUND("Montant Retenue G. DS", RecGGeneralLedgerSetup."Amount Rounding Precision");
        end else
            if ("Montant Retenue G." <> 0) and ("Montant Retenue G. Validé" = 0) and
            (RecGPaymentStatus1."Calculer Retenue sur Garantie") then begin
                if "Currency Code" <> '' then
                    "Montant Retenue G. DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date",
                    "Currency Code", "Montant Retenue G.",
                    "Currency Factor"), RecGCurrency1."Amount Rounding Precision")
                else
                    "Montant Retenue G. DS" := ROUND("Montant Retenue G.", RecGGeneralLedgerSetup."Amount Rounding Precision");
            end;

        if RecGPaymentStatus1."Calculer Retenue sur Garantie" then
            MntRGart := "Montant Retenue G.";
        if RecGPaymentStatus1."Calculer Retenue à la source" then
            MntRetenu := "Montant Retenue";
        if RecGPaymentStatus1."Calculer Retenue Sur TVA" then
            MntTva := "Montant Retenue TVA";
        MntTva := "Montant Retenue TVA" + "Montant Retenue TVA Validé";
        if RecGPaymentStatus1.Commission then
            MntComm := "Montant Commission" + "Montant Commission Validé";
        if RecGPaymentStatus1."Tva Sur Commission" then
            MntTvaComm := "Montant TVA sur Commission" + "Montant TVA sur Com. validé";
        Validate(Amount, "Montant Initial" + (MntRetenu + MntTva + MntRGart));
    end;

    procedure LibererCheque()
    begin
        //>> HJ DSFT 11 11 2010
        CalcFields("N° compte En tête");
        REcChèquemouvementé.SetRange("Code banque", "N° compte En tête");
        REcChèquemouvementé.SetRange("Référence chèque", "Référence chèque");
        if "N° chèque" <> 0 then
            REcChèquemouvementé.SetRange("N°Chèque", "N° chèque")
        else
            REcChèquemouvementé.SetRange("N°Chèque", xRec."N° chèque");
        if REcChèquemouvementé.FindFirst then begin
            REcChèquemouvementé."N° Bordereu" := '';
            REcChèquemouvementé."N° Ligne Bordereu" := 0;
            REcChèquemouvementé."Statut Bordereau" := '';
            REcChèquemouvementé."N° Statut" := 0;
            REcChèquemouvementé.Statut := 0;
            REcChèquemouvementé.Modify;
        end;
        //>> HJ DSFT 11 11 2010
    end;


    trigger OnBeforeDelete()
    var
        text0009: Label 'Vous n''avez pas le droit de supprimer la ligne.';
    begin
        //GL2026
        if "Status No." > 0 then
            Error(text0009);
        //GL2026
    end;


    var
        "//DSFT-TRIUM": Text[30];
        RecGCurrency: Record Currency;
        RecGPaymentStatus: Record "Payment Status";
        RecGCurrencyExchangeRate: Record "Currency Exchange Rate";
        RecGGeneralLedgerSetup: Record "General Ledger Setup";
        RecGPaymentStatus1: Record "Payment Status";
        RecGCustomer: Record Customer;
        RecGVendor: Record Vendor;
        RecGCurrency1: Record Currency;
        RecGPaymentStepLedger: Record "Payment Step Ledger";
        "VarD%Retenue": Decimal;
        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        MntRGart: Decimal;
        Custledger: Record "Cust. Ledger Entry";
        MntRet: Decimal;
        MntRetenu: Decimal;
        MntTva: Decimal;
        MntComm: Decimal;
        MntTvaComm: Decimal;
        RecGGLAccount: Record "G/L Account";
        RecGEmployee: Record Employee;
        RecGBankAccount: Record "Bank Account";
        RecGGLSetup: Record "General Ledger Setup";
        RecGItemCharge: Record "Item Charge";
        "REcChèquemouvementé": Record "Chèque mouvementé";
        "//HJ DSFT": Integer;
        RecPaymentHeader: Record "Payment Header";
        //  MotifDepense: Record "Code Opération Caisse";
        //  Loyer: Record Loyer;
        DateEch: Date;
        FrmLoyer: Page Loyer;
        MontantInitial: Decimal;
        "// RB SORO 14/04/2015": Integer;
        RecVendorPaymentLine: Record "Payment Line";
        RecSalarier: Record Salarier;
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;

        // OperationCaisse: Record "Code Opération Caisse";
        NoSeriesManagment: Codeunit NoSeriesManagement;
        RecPaymentLineCaisse: Record "Payment Line";
        //  RecAffectation: Record Section;
        RecEmployee: Record Employee;
        // RecEnteteLotPaie: Record "Entete Lot Paie";
        VendorBank: Record "Vendor Bank Account";
        //  Text002: Label 'Vérifier le numero du Piece de Paiement !!!';
        RecPaymentHeader2: Record "Payment Header";
        PaymentClass: Record "Payment Class";
    //  MotifDepenseExt: Record 50000;
}

