TableExtension 50019 "Purchase HeaderEXT" extends "Purchase Header"
{
    fields
    {

        modify("Buy-from Vendor No.")
        {
            TableRelation = if ("Document Type" = const("Note of Expenses")) Vendor where("Prices Including VAT" = const(true))
            else
            Vendor;
            Caption = 'Buy-from Vendor No.';
            trigger OnBeforeValidate()
            var
                RecVendor: Record Vendor;
            begin
                IF Imprimer THEN ERROR(Text058);
                if RecVendor.Get(Rec."Buy-from Vendor No.") then
                    Rec."Appliquer Fodec" := RecVendor."Appliquer Fodec";
            end;
        }


        modify("Pay-to Name 2")
        {
            Caption = 'Pay-to Name 2';
            Description = 'Observation 3';
            trigger OnBeforeValidate()
            begin
                /* {
                                                               // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                                                               IF RecCopieEntetAchat.GET("Document Type", "No.") THEN BEGIN
                   IF "Pay-to Name 2" <> '' THEN BEGIN
                       RecCopieEntetAchat."Nø Demande d'achat" := "Nø Demande d'achat";
                       RecCopieEntetAchat."Nø DA Chantier" := "Nø DA Chantier";
                       RecCopieEntetAchat."Date DA" := "Date DA";
                       RecCopieEntetAchat."Nø Devis Fournisseur" := "Nø Devis Fournisseur";
                       RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                       RecCopieEntetAchat."Pays provenance" := "Entry Point";
                       RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                       RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                       RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                       RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                       RecCopieEntetAchat.MODIFY;
                   END;
               END
               ELSE BEGIN
                   // Nouvelle Insertion
                   RecCopieEntetAchat."Type Document" := "Document Type";
                   RecCopieEntetAchat."Nø Demande d'achat" := "Nø Demande d'achat";
                   RecCopieEntetAchat."Nø DA Chantier" := "Nø DA Chantier";
                   RecCopieEntetAchat."Date DA" := "Date DA";
                   RecCopieEntetAchat."Nø Devis Fournisseur" := "Nø Devis Fournisseur";
                   RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                   RecCopieEntetAchat."Pays provenance" := "Entry Point";
                   RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                   RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                   RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                   RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                   RecCopieEntetAchat."Nø Document" := "No.";
                   IF NOT RecCopieEntetAchat.INSERT THEN RecCopieEntetAchat.MODIFY;
                   // Nouvelle Insertion
               END;
                                                               }*/
            end;



        }


        modify("Pay-to Address 2")
        {

            Description = 'Observation 2';
            Caption = 'Pay-to Address 2';
            trigger OnBeforeValidate()
            begin
                /* {
                                                                // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                                                                IF RecCopieEntetAchat.GET("Document Type", "No.") THEN BEGIN
                    IF "Pay-to Address 2" <> '' THEN BEGIN
                        RecCopieEntetAchat."Nø Demande d'achat" := "Nø Demande d'achat";
                        RecCopieEntetAchat."Nø DA Chantier" := "Nø DA Chantier";
                        RecCopieEntetAchat."Date DA" := "Date DA";
                        RecCopieEntetAchat."Nø Devis Fournisseur" := "Nø Devis Fournisseur";
                        RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                        RecCopieEntetAchat."Pays provenance" := "Entry Point";
                        RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                        RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                        RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                        RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                        RecCopieEntetAchat.MODIFY;
                    END;
                END
                ELSE BEGIN
                    // Nouvelle Insertion
                    RecCopieEntetAchat."Type Document" := "Document Type";
                    RecCopieEntetAchat."Nø Demande d'achat" := "Nø Demande d'achat";
                    RecCopieEntetAchat."Nø DA Chantier" := "Nø DA Chantier";
                    RecCopieEntetAchat."Date DA" := "Date DA";
                    RecCopieEntetAchat."Nø Devis Fournisseur" := "Nø Devis Fournisseur";
                    RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                    RecCopieEntetAchat."Pays provenance" := "Entry Point";
                    RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                    RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                    RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                    RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                    RecCopieEntetAchat."Nø Document" := "No.";
                    IF NOT RecCopieEntetAchat.INSERT THEN RecCopieEntetAchat.MODIFY;
                    // Nouvelle Insertion
                END;
                                                                }*/
            end;


        }



        /*GL2024  modify(Status)
          {
              Editable=TRUE;

          }*/
        modify("Buy-from IC Partner Code")
        {
            Caption = 'Buy-from IC Partner Code';
        }
        modify("Buy-from Contact No.")
        {
            Caption = 'Buy-from Contact No.';
        }





        modify("Posting Date")
        {
            trigger OnBeforeValidate()
            begin
                // RB SORO 29/04/2016
                IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) THEN BEGIN
                    IF "Posting Date" > WORKDATE THEN
                        ERROR(Text059);
                END;
                // RB SORO 29/04/2016
            end;
        }


        /* modify("Payment Terms Code")
         {
             trigger OnAfterValidate()
             begin
                 // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                 IF RecCopieEntetAchat.GET("Document Type", "No.") THEN BEGIN
                     IF "Payment Terms Code" <> '' THEN BEGIN
                         RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                         RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                         RecCopieEntetAchat."Date DA" := "Date DA";
                         RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                         RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                         RecCopieEntetAchat."Pays provenance" := "Entry Point";
                         RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                         RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                         RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                         RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                         RecCopieEntetAchat.MODIFY;
                     END;
                 END
                 ELSE BEGIN
                     // Nouvelle Insertion
                     RecCopieEntetAchat."Type Document" := "Document Type";
                     RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                     RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                     RecCopieEntetAchat."Date DA" := "Date DA";
                     RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                     RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                     RecCopieEntetAchat."Pays provenance" := "Entry Point";
                     RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                     RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                     RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                     RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                     RecCopieEntetAchat."N° Document" := "No.";
                     IF NOT RecCopieEntetAchat.INSERT THEN RecCopieEntetAchat.MODIFY;
                     // Nouvelle Insertion
                 END;
             end;
         }*/

        modify("Location Code")
        {
            trigger OnBeforeValidate()
            var
            // RecAutorisationMagasin: Record "Autorisation Magasin";
            //Text0001: label 'FRA=Magasin non Autorisé !!!';

            begin
                // RB SORO 09/06/2015

                //"CUPurch.-Post".AutorisationMagasin("Location Code");

                // RB SORO 09/06/2015
            end;

            trigger OnAfterValidate()
            begin
                // >> HJ SORO 26-02-2015
                //IF "Nø Demande d'achat"<>'' THEN ERROR(Text055);
                // >> HJ SORO 26-02-2015
            end;
        }



        modify("Purchaser Code")
        {
            trigger OnAfterValidate()
            var
                RecPurchaser: Record "Salesperson/Purchaser";
            begin
                // // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                // IF RecCopieEntetAchat.GET("Document Type", "No.") THEN BEGIN
                //     IF "Purchaser Code" <> '' THEN BEGIN
                //         RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                //         RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                //         RecCopieEntetAchat."Date DA" := "Date DA";
                //         RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                //         RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                //         RecCopieEntetAchat."Pays provenance" := "Entry Point";
                //         RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                //         RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                //         RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                //         RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                //         RecCopieEntetAchat.MODIFY;
                //     END;
                // END
                // ELSE BEGIN
                //     // Nouvelle Insertion
                //     RecCopieEntetAchat."Type Document" := "Document Type";
                //     RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                //     RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                //     RecCopieEntetAchat."Date DA" := "Date DA";
                //     RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                //     RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                //     RecCopieEntetAchat."Pays provenance" := "Entry Point";
                //     RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                //     RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                //     RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                //     RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                //     RecCopieEntetAchat."N° Document" := "No.";
                //     IF NOT RecCopieEntetAchat.INSERT THEN RecCopieEntetAchat.MODIFY;
                //     // Nouvelle Insertion

                // END;
                Rec.Designation := '';
                if RecPurchaser.Get(Rec."Purchaser Code") then
                    Rec.Designation := RecPurchaser.Name;
            end;
        }
        modify("Vendor Shipment No.")
        {
            trigger OnAfterValidate()
            Var
                RecPurchaseheader: Record "Purchase Header";
            begin
                // >> HJ DELTA 10-03-2014
                if "Vendor Shipment No." <> '' then begin


                    RecPurchaseheader.RESET;
                    RecPurchaseheader.SETRANGE("Vendor Shipment No.", "Vendor Shipment No.");
                    RecPurchaseheader.SETRANGE("Buy-from Vendor No.", "Buy-from Vendor No.");
                    IF RecPurchaseheader.FINDFIRST THEN begin
                        if RecPurchaseheader.Count > 1 then
                            ERROR(Text054);
                    end;
                    PurchRcptHeader.RESET;
                    PurchRcptHeader.SETRANGE("Vendor Shipment No.", "Vendor Shipment No.");
                    PurchRcptHeader.SETRANGE("Buy-from Vendor No.", "Buy-from Vendor No.");
                    IF PurchRcptHeader.FINDFIRST THEN ERROR(Text054);
                end;
                // >> HJ DELTA 10-03-2014
            end;
        }

        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            begin
                // >> HJ DELTA 10-03-2014
                RecPurchaseHeaderFact.RESET;
                RecPurchaseHeaderFact.SETRANGE("Vendor Invoice No.", "Vendor Invoice No.");
                RecPurchaseHeaderFact.SETRANGE("Buy-from Vendor No.", "Buy-from Vendor No.");
                RecPurchaseHeaderFact.SETRANGE("Document Type", Rec."Document Type");
                IF RecPurchaseHeaderFact.FINDFIRST THEN ERROR(Text056);

                RecPurchInvHeaderFact.RESET;
                RecPurchInvHeaderFact.SETRANGE("Vendor Invoice No.", "Vendor Invoice No.");
                RecPurchInvHeaderFact.SETRANGE("Buy-from Vendor No.", "Buy-from Vendor No.");
                IF RecPurchInvHeaderFact.FINDFIRST THEN ERROR(Text057);
                // >> HJ DELTA 10-03-2014
            end;
        }








        /*  modify("Entry Point")
          {
              trigger OnAfterValidate()
              begin

                  // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                  IF RecCopieEntetAchat.GET("Document Type", "No.") THEN BEGIN
                      IF "Entry Point" <> '' THEN BEGIN
                          RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                          RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                          RecCopieEntetAchat."Date DA" := "Date DA";
                          RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                          RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                          RecCopieEntetAchat."Pays provenance" := "Entry Point";
                          RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                          RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                          RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                          RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                          RecCopieEntetAchat.MODIFY;
                      END;
                  END
                  ELSE BEGIN
                      // Nouvelle Insertion
                      RecCopieEntetAchat."Type Document" := "Document Type";
                      RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                      RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                      RecCopieEntetAchat."Date DA" := "Date DA";
                      RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                      RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                      RecCopieEntetAchat."Pays provenance" := "Entry Point";
                      RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                      RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                      RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                      RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                      RecCopieEntetAchat."N° Document" := "No.";
                      IF NOT RecCopieEntetAchat.INSERT THEN RecCopieEntetAchat.MODIFY;
                      // Nouvelle Insertion
                  END;
              end;
          }*/

        modify("Document Date")
        {
            trigger OnBeforeValidate()
            begin
                // MH SORO 22/01/2020
                IF ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) THEN BEGIN
                    IF "Document Date" > WORKDATE THEN
                        ERROR(Text059);
                END;
                // MH SORO 22/01/2020

            end;

            trigger OnAfterValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Document Date"));
                //+ABO+//
            end;
        }

        modify("Payment Method Code")
        {
            trigger OnAfterValidate()
            begin
                PaymentMethod.INIT;
                IF "Payment Method Code" <> '' THEN BEGIN
                    //#8772
                    "Reason Code" := PaymentMethod."Reason Code"
                    //#8772//
                END;

            end;
        }

        field(11000; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(50000; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Stamp Fiscal';
            Description = 'STD V1.0';
            InitValue = false;
        }
        field(50001; "N° Dossier"; Code[20])
        {
            TableRelation = "Dossiers d'Importation"."N° Dossier";

            trigger OnValidate()
            begin
                //>>MBY 02/01/2012
                //GL2024  UpdatePurchLines(FieldCaption("N° Dossier"));
                UpdatePurchLines(FieldCaption("N° Dossier"), false);

                UpdateLine;
                //>>MBY 02/01/2012
            end;
        }
        field(50002; "N° Sequence"; Integer)
        {
        }
        field(50003; "Type Demande"; Option)
        {
            Description = 'HJ DSFT';
            OptionMembers = "Piece De Rechange",Meteriaux,"Fourniture Et Divers","Prestation De service";
        }
        field(50004; Approbateur; Code[50])
        {
            Description = 'HJ DSFT 18-10-2012';
        }
        field(50005; Synchronise; Boolean)
        {
        }
        field(50006; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 19-05-2015';
        }
        field(50008; "Date Vérification"; Date)
        {
            Description = 'MBY';
        }
        field(50009; Contrat; Boolean)
        {
            Editable = true;
        }
        field(50011; "N° Demande d'achat"; Code[20])
        {
            Editable = true;

            /*   trigger OnValidate()
               begin
                   // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                   if RecCopieEntetAchat.Get("Document Type", "No.") then begin
                       if "N° Demande d'achat" <> '' then begin
                           RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                           RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                           RecCopieEntetAchat."Date DA" := "Date DA";
                           RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                           RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                           RecCopieEntetAchat."Pays provenance" := "Entry Point";
                           RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                           RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                           RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                           RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                           RecCopieEntetAchat.Modify;
                       end;
                   end
                   else begin
                       // Nouvelle Insertion
                       RecCopieEntetAchat."Type Document" := "Document Type";
                       RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                       RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                       RecCopieEntetAchat."Date DA" := "Date DA";
                       RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                       RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                       RecCopieEntetAchat."Pays provenance" := "Entry Point";
                       RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                       RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                       RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                       RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                       RecCopieEntetAchat."N° Document" := "No.";
                       if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
                       // Nouvelle Insertion
                   end;
               end;*/
        }
        field(50012; "Date DA"; Date)
        {
            Description = 'HJ DSFT 01-02-2013';

            /*   trigger OnValidate()
               begin
                   // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                   if RecCopieEntetAchat.Get("Document Type", "No.") then begin
                       if "Date DA" <> 0D then begin
                           RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                           RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                           RecCopieEntetAchat."Date DA" := "Date DA";
                           RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                           RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                           RecCopieEntetAchat."Pays provenance" := "Entry Point";
                           RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                           RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                           RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                           RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                           RecCopieEntetAchat.Modify;
                       end;
                   end
                   else begin
                       // Nouvelle Insertion
                       RecCopieEntetAchat."Type Document" := "Document Type";
                       RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                       RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                       RecCopieEntetAchat."Date DA" := "Date DA";
                       RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                       RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                       RecCopieEntetAchat."Pays provenance" := "Entry Point";
                       RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                       RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                       RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                       RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                       RecCopieEntetAchat."N° Document" := "No.";
                       if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
                       // Nouvelle Insertion
                   end;
               end;*/
        }
        field(50014; "Statut Commande"; Option)
        {
            Editable = false;
            OptionMembers = " ","Non Livré","Partiellement Livré","Totallement Livré";
        }
        field(50015; "Statut Facture"; Option)
        {
            OptionMembers = "En Cours De Préparation","En Instance";
            Caption = 'Statut Facture';
        }
        field(50016; "Remarque de Livrison"; Text[100])
        {
            Description = 'RB SORO 29/12/2015';
        }
        field(50017; "Etat Commande"; Option)
        {
            OptionMembers = Normal,"En Instance",Reclamation,Annulation,Devise,"Avance Bloquée","Avance Debloquée";

            /* trigger OnValidate()
             var
                 LMessage: Text[50];
             begin
                 // >> HJ SORO 10-04-2018
                 if ("Etat Commande" = "etat commande"::"Avance Bloquée") or ("Etat Commande" = "etat commande"::"Avance Debloquée") then begin
                     LMessage := UpperCase(Format("Etat Commande"));
                     SalesHeader.SetRange("No.", "N° Demande d'achat");
                     if SalesHeader.FindFirst then begin
                         SalesContributor.SetRange("Job No.", "Job No.");
                         SalesContributor.SetRange(Approbateur, UpperCase(SalesHeader.Approbateur));
                         if SalesContributor.FindFirst then
                             //DYS Mail.SendMail utilise automation
                             // if SalesHeader."Mode Notification" = SalesHeader."mode notification"::Mail then
                             //     Mail.SendMail(SalesContributor.Mail, 'NAVISION : NOTIFICATION ' +
                             //       LMessage + 'POUR DA N° ' + "N° Demande d'achat",
                             //     LMessage + ' POUR LA COMMANDE  ' + "No." + ' LIE A LA DA N° ' + "N° Demande d'achat");
                             Mail.NotificationDa("N° Demande d'achat", LMessage, "Job No.", WorkDate, "User ID");

                     end;
                 end;
                 // >> HJ SORO 10-04-2018
             end;*/
        }
        field(50018; "Generer A Partir DA"; Code[20])
        {
            /*  TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                          "Order Type" = const("Supply Order"),
                                                          Status = const(Released));*/
            // TableRelation = "Purchase Request" where("Statut" = const(approved));
            //  TableRelation = "Purchase Request"."No." where(Statut = filter(approved | "partially supported"));
            TableRelation = "Purchase Request"."No.";
        }
        field(50019; "DA Créer Par"; Code[20])
        {
        }
        field(50020; "Nom Affectation"; Text[50])
        {
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Purchaser Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Nom Lieu Liv"; Text[50])
        {
            CalcFormula = lookup("Entry/Exit Point".Description where(Code = field("Entry Point")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Nom Condition Paiement"; Text[50])
        {
            CalcFormula = lookup("Payment Terms".Description where(Code = field("Payment Terms Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; Demarcheur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        // field(50024; Contrat; Boolean)
        // {
        // }
        /*  field(50025; "Date Bureau Ordre"; Date)
          {

              trigger OnValidate()
              begin
                  // MH SORO 22/01/2020
                  if ("Document Type" = "document type"::Order) or ("Document Type" = "document type"::Invoice) then begin
                      if "Date Bureau Ordre" > WorkDate then
                          Error(Text059);
                  end;
                  // MH SORO 22/01/2020
              end;
          }*/
        field(50026; "Date Saisie"; Date)
        {
            Description = 'HJ SORO 03-02-2015';
            Editable = false;
        }
        field(50027; "Facture En Instance"; Boolean)
        {
        }
        field(50028; "Appliquer Fodec"; Boolean)
        {
            Description = 'RB SORO 07/04/2015';
        }
        field(50029; "N° Devis Fournisseur"; Code[20])
        {
            Description = 'RB SORO 07/04/2015';

            /*  trigger OnValidate()
              begin
                  // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                  if RecCopieEntetAchat.Get("Document Type", "No.") then begin
                      if "N° Devis Fournisseur" <> '' then begin
                          RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                          RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                          RecCopieEntetAchat."Date DA" := "Date DA";
                          RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                          RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                          RecCopieEntetAchat."Pays provenance" := "Entry Point";
                          RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                          RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                          RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                          RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                          RecCopieEntetAchat.Modify;
                      end;
                  end
                  else begin
                      // Nouvelle Insertion
                      RecCopieEntetAchat."Type Document" := "Document Type";
                      RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                      RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                      RecCopieEntetAchat."Date DA" := "Date DA";
                      RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                      RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                      RecCopieEntetAchat."Pays provenance" := "Entry Point";
                      RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                      RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                      RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                      RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                      RecCopieEntetAchat."N° Document" := "No.";
                      if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
                      // Nouvelle Insertion
                  end;
              end;*/
        }
        field(50030; "Motif Annulation"; Text[30])
        {
            Description = 'RB SORO 10/04/2015';
        }
        field(50031; "N° DA Chantier"; Code[20])
        {
            Description = 'RB SORO 17/04/2015';

            /*  trigger OnValidate()
              var

              begin
                  // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                  if RecCopieEntetAchat.Get("Document Type", "No.") then begin
                      if "N° DA Chantier" <> '' then begin
                          RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                          RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                          RecCopieEntetAchat."Date DA" := "Date DA";
                          RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                          RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                          RecCopieEntetAchat."Pays provenance" := "Entry Point";
                          RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                          RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                          RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                          RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                          RecCopieEntetAchat.Modify;
                      end;
                  end
                  else begin
                      // Nouvelle Insertion
                      RecCopieEntetAchat."Type Document" := "Document Type";
                      RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                      RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                      RecCopieEntetAchat."Date DA" := "Date DA";
                      RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                      RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                      RecCopieEntetAchat."Pays provenance" := "Entry Point";
                      RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                      RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                      RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                      RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                      RecCopieEntetAchat."N° Document" := "No.";
                      if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
                      // Nouvelle Insertion
                  end;
              end;*/
        }
        field(50032; Demandeur; Code[50])
        {
            Description = 'HJ SORO 18-04-2015';
            Editable = false;
        }
        field(50033; Engins; Code[20])
        {
            Description = 'HJ SORO 18-04-2015';
        }
        field(50034; "Description Engins"; Text[100])
        {
            Description = 'HJ SORO 18-04-2015';
        }
        field(50035; "Magasin DA"; Code[20])
        {
            Description = 'HJ SORO 18-04-2015';
            Editable = false;
        }
        field(50036; Utilisateur; Code[50])
        {
            Description = 'HJ SORO 18-04-2015';
            Editable = false;
            Caption = 'Code Utilisateur';
        }
        field(50037; Decharge; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50038; Imprimer; Boolean)
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
        field(50041; "Observation 01"; Text[100])
        {
            Description = 'MH SORO 06/06/2015';
            Enabled = false;
        }
        field(50042; Simulation; Boolean)
        {
            Description = 'RB SORO 16/03/2016';
        }
        field(50043; "Date Initial DA"; Date)
        {
            Description = 'HJ SORO 08-08-2018';
            Editable = false;
        }
        field(50044; "Appliquer Redevance"; Boolean)
        {
            Description = 'MH SORO 09-09-2019';
        }
        field(50045; "Appliquer Fond Soutient"; Boolean)
        {
            Description = 'MH SORO 09-09-2019';
        }
        field(50046; "Finance"; Option)
        {
            OptionMembers = " ","FINANCE 1","FINANCE 2";
        }

        // field(50999; "Num Sequence Syncro"; Integer)
        // {
        //     Description = 'RB SORO 06/03/2015';
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
        //     //ValidateTableRelation = false;
        // }
        field(51000; "Pay-to Address Soroubat"; Text[100])
        {
            Caption = 'Pay-to Address Soroubat';
        }
        field(51001; "Pay-to Address 2 Soroubat"; Text[100])
        {
            Caption = 'Pay-to Address 2 Soroubat';
        }
        field(51002; "Montant Total"; Decimal)
        {
            Caption = 'Montant Total';
        }
        field(50211; "Purchase Request No."; Code[20])
        {
            Caption = 'Purchase Request No.';
            Editable = true;

            /*  trigger OnValidate()
              begin
                  // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                  IF RecCopieEntetAchat.GET("Document Type", "No.") THEN BEGIN
                      IF "Purchase Request No." <> '' THEN BEGIN
                          RecCopieEntetAchat."N° Demande d'achat" := "Purchase Request No.";
                          // RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                          RecCopieEntetAchat."Date DA" := "Date DA";
                          RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                          RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                          RecCopieEntetAchat."Pays provenance" := "Entry Point";
                          RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                          RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                          RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                          RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                          RecCopieEntetAchat.MODIFY;
                      END;
                  END
                  ELSE BEGIN
                      // Nouvelle Insertion
                      RecCopieEntetAchat."Type Document" := "Document Type";
                      RecCopieEntetAchat."N° Demande d'achat" := "Purchase Request No.";
                      //RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                      RecCopieEntetAchat."Date DA" := "Date DA";
                      RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                      RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                      RecCopieEntetAchat."Pays provenance" := "Entry Point";
                      RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                      RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                      RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                      RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                      RecCopieEntetAchat."N° Document" := "No.";
                      IF NOT RecCopieEntetAchat.INSERT THEN RecCopieEntetAchat.MODIFY;
                      // Nouvelle Insertion
                  END;

              end;*/
        }
        field(50060; "Observation 1"; text[100])
        {
            Caption = 'Observation 1';
            Description = 'MH SORO 14-12-2024';

        }

        field(50061; "Observation 2"; text[100])
        {
            Caption = 'Observation 2';
            Description = 'MH SORO 14-12-2024';

        }
        field(61062; "Entree Bureau Ordre"; Boolean)
        {
            Caption = 'Entrée Bureau Ordre';


        }

        field(59162; "Observation 3"; text[100])
        {
            Caption = 'Observation 3';
            Description = 'MH SORO 14-12-2024';

        }
        field(80321; "Designation"; Text[50])
        {
            Caption = 'Designation Affectation';
            DataClassification = ToBeClassified;
        }
        field(60002; "Date Bureau Ordre"; Date)
        {
            Description = 'HJ SORO 17-04-2014';

        }

        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(3010541; "Reference No."; Code[35])
        {
            Caption = 'N° référence';

            trigger OnValidate()
            begin
                DtaMgt.PurchHeadRefNoProcess(Rec);
            end;
        }
        field(3010542; "Bank Code"; Code[10])
        {
            Caption = 'Code de banque';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("Pay-to Vendor No."));
        }
        field(3010543; Checksum; Code[20])
        {
            Caption = 'Checksum';

            trigger OnValidate()
            begin
                Validate("Reference No.");
            end;
        }
        field(3010544; "DTA Coding Line"; Code[70])
        {
            Caption = 'Ligne de codage DTA';
            // TableRelation = "Bureau Ordre Diffusion"."Référence Ligne" where("N° Fournisseur" = field("Buy-from Vendor No."));

            trigger OnValidate()
            begin
                DtaMgt.ProcessPurchHeader(Rec, "DTA Coding Line");
            end;
        }
        field(3010545; "ESR Amount"; Decimal)
        {
            Caption = 'Montant BVR';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                DtaMgt.PurchHeadRefNoProcess(Rec);
            end;
        }
        field(8001400; "Date Next Follow-Up"; Date)
        {
            Caption = 'Date Next Follow-Up';

            trigger OnValidate()
            var
                lToDo: Record "To-do" temporary;
            begin
                //+REF+ACHAT_SUIVI
                if "Date Next Follow-Up" <> 0D then begin
                    lToDo.Type := lToDo.Type::"Phone Call";
                    //#7897
                    //  lToDo.Description := PADSTR(STRSUBSTNO(tFollowUpText,"No."),50);
                    lToDo.Description := PadStr(StrSubstNo(tFollowUpText, "Document Type", "No."), 50);
                    //#7897
                    lToDo.Date := "Date Next Follow-Up";
                    lToDo."Salesperson Code" := "Purchaser Code";
                    lToDo."Contact No." := "Buy-from Contact No.";
                    lToDo.SetDuration(lToDo.Date, Time);

                    lToDo.Insert;
                    page.RunModal(page::"Task Card", lToDo);
                end;
                //+REF+ACHAT_SUIVI//
            end;
        }
        field(8001401; "User ID"; Code[50])
        {
            Caption = 'Code Utilisateur';
            Editable = true;
            NotBlank = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
                RecUser: Record User;
            begin

                LoginMgt.DisplayUserInformationBySID("User ID");
            end;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Subscription Starting Date"));
                //+ABO+//
            end;
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Subscription End Date"));
                //+ABO+//
            end;
        }
        field(8001902; "Next Invoice Calculation"; DateFormula)
        {
            Caption = 'Next Invoice Calculation';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Next Invoice Calculation"));
                //+ABO+//
            end;
        }
        field(8001903; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            Editable = false;
        }
        field(8001904; "Source Invoice No."; Code[20])
        {
            Caption = 'Source Invoice No.';
        }
        field(8001905; "Invoicing Periodicity Code"; Code[20])
        {
            Caption = 'Invoicing Periodicity Code';

            TableRelation = "Subscr. Invoicing Period";


            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Invoicing Periodicity Code"));
                //+ABO+//
            end;
        }
        field(8003900; "Ship-to Job No."; Code[20])
        {
            Caption = 'Ship-to Address Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                lJob: Record Job;
            begin
                TestField(Status, Status::Open);
                UpdateShipToAddress;
            end;
        }
        field(8003901; "Ship-to Contact No."; Code[20])
        {
            Caption = 'Ship-to Contact No.';
            TableRelation = Contact;

            trigger OnValidate()
            var
                lContact: Record Contact;
            begin
                TestField(Status, Status::Open);
                UpdateShipToAddress;
            end;
        }
        field(8003902; "Shipment Method to"; Text[30])
        {
            Caption = 'Shipment Method to';

            /* trigger OnValidate()
             begin
                 // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE COMMANDE ACHAT
                 if RecCopieEntetAchat.Get("Document Type", "No.") then begin
                     if "Shipment Remark" <> '' then begin
                         RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                         RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                         RecCopieEntetAchat."Date DA" := "Date DA";
                         RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                         RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                         RecCopieEntetAchat."Pays provenance" := "Entry Point";
                         RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                         RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                         RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                         RecCopieEntetAchat."Observation 3" := "Pay-to Name 2";
                         RecCopieEntetAchat.Modify;
                     end;
                 end
                 else begin
                     // Nouvelle Insertion
                     RecCopieEntetAchat."Type Document" := "Document Type";
                     RecCopieEntetAchat."N° Demande d'achat" := "N° Demande d'achat";
                     RecCopieEntetAchat."N° DA Chantier" := "N° DA Chantier";
                     RecCopieEntetAchat."Date DA" := "Date DA";
                     RecCopieEntetAchat."N° Devis Fournisseur" := "N° Devis Fournisseur";
                     RecCopieEntetAchat."Code acheteur" := "Purchaser Code";
                     RecCopieEntetAchat."Pays provenance" := "Entry Point";
                     RecCopieEntetAchat."Code condition paiement" := "Payment Terms Code";
                     RecCopieEntetAchat."Observation 1" := "Shipment Remark";
                     RecCopieEntetAchat."Observation 2" := "Pay-to Address 2";
                     RecCopieEntetAchat."Observation 3" := "Ship-to Name 2";
                     RecCopieEntetAchat."N° Document" := "No.";
                     if not RecCopieEntetAchat.Insert then RecCopieEntetAchat.Modify;
                     // Nouvelle Insertion
                 end;
             end;*/
        }
        field(8003903; "Shipment Remark"; Text[100])
        {
            Caption = 'Shipment Remark 2';
            Description = 'Observation 1';
            trigger OnValidate()
            begin
                "Remarque de Livrison" := "Shipment Remark";

            end;
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'N° Affaire';
            Description = 'Modification TableRelation';
            TableRelation = Job."No." where("IC Partner Code" = const());

            trigger OnValidate()
            var
                lJob: Record Job;
                lJobStatus: Record "Job Status";
                txt01: label 'Affaire non associé à aucune magasin, Contacter votre Administrateur Pour affecter l''affaire %1 à une magasin';
                "// RB SORO 14/05/2015": Integer;
                RecLocationJob: Record Location;
                DimSource: List of [Dictionary of [Integer, Code[20]]];
                DimDictionary: Dictionary of [Integer, Code[20]];

            begin
                //JOB_STATUS
                if "Job No." <> '' then begin
                    lJob.wCheckBlockedJob("Job No.");
                    // with lJobStatus do
                    //     Check("Job No.", FieldNo("Purchase Order"));
                end;
                //JOB_STATUS//

                //MessageIfPurchLinesExist(FIELDCAPTION("Job No."));
                if PurchLinesExist then
                    //GL2024   UpdatePurchLines(FieldCaption("Job No."));
                    UpdatePurchLines(FieldCaption("Job No."), false);
                //PROJET//

                //MULTI_ADDR
                Validate("Ship-to Job No.", "Job No.");
                //MULTI_ADDR//

                /*GL2024  CreateDim(
                                  Database::Job, "Job No.",
                                  Database::Vendor, "Pay-to Vendor No.",
                                  Database::"Salesperson/Purchaser", "Purchaser Code",
                                  Database::Campaign, "Campaign No.",
                                  Database::"Responsibility Center", "Responsibility Center");*/

                DimDictionary.Add(DATABASE::"Job", "Job No.");
                DimDictionary.Add(DATABASE::vendor, "Pay-to Vendor No.");
                DimDictionary.Add(DATABASE::"Salesperson/Purchaser", "Purchaser Code");
                DimDictionary.Add(DATABASE::Campaign, "Campaign No.");
                DimDictionary.Add(DATABASE::"Responsibility Center", "Responsibility Center");
                DimSource.Add(DimDictionary);
                CreateDim(DimSource);
                //MASK
                if "Job No." = '' then
                    "Mask Code" := ''
                else
                    if lJob.Get("Job No.") then
                        "Mask Code" := lJob."Mask Code";
                //MASK//

                // RB SORO 14/05/2015 LOCATION CODE WITH JOB N°
                RecJob.Reset;
                if RecJob.Get("Job No.") then;
                if RecJob."Affectation Magasin" <> '' then
                    Validate("Location Code", RecJob."Affectation Magasin")
                else
                    Message(txt01, "Job No.");
                // RB SORO 14/05/2015 LOCATION CODE WITH JOB N°
            end;
        }
        field(8003924; "Apply-to Sales Order No."; Code[20])
        {
            Caption = 'Apply-to Sales Doc. No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "No." = field("Apply-to Sales Order No."),
                                                        "Order Type" = const(" "));

            trigger OnLookup()
            var
                lSalesHeader: Record "Sales Header";
            begin
                //#7814
                lSalesHeader.FilterGroup(2);
                lSalesHeader.SetRange("Document Type", lSalesHeader."document type"::Order);
                lSalesHeader.SetRange("Order Type", lSalesHeader."order type"::" ");
                lSalesHeader.FilterGroup(0);
                if "Job No." <> '' then
                    lSalesHeader.SetRange("Job No.", "Job No.");
                if page.RunModal(0, lSalesHeader) = Action::LookupOK then
                    //#8500
                    //  "Apply-to Sales Order No." := lSalesHeader."No.";
                    Validate("Apply-to Sales Order No.", lSalesHeader."No.");
                //#8500//
                //#7814//
            end;

            trigger OnValidate()
            var
                lSalesHeader: Record "Sales Header";
                ltPaymentTermsAndMethod: label 'Payment terms and payment method will be those of sales-order.\Do you want to continue?';
            begin
                //#5284
                if ("Apply-to Sales Order No." <> xRec."Apply-to Sales Order No.") and ("Apply-to Sales Order No." <> '') then begin
                    lSalesHeader.Get("document type"::Order, "Apply-to Sales Order No.");
                    TestField("Currency Code", lSalesHeader."Currency Code");
                    if ("Payment Terms Code" <> lSalesHeader."Payment Terms Code") or
                       ("Payment Method Code" <> lSalesHeader."Payment Method Code") then begin
                        if not Confirm(ltPaymentTermsAndMethod, false, "Payment Terms Code", "Payment Method Code") then
                            Error('');
                        "Payment Terms Code" := lSalesHeader."Payment Terms Code";
                        "Payment Method Code" := lSalesHeader."Payment Method Code";
                    end;
                end;
                //#5284//
            end;
        }
        field(8004090; "Attached to Doc. No."; Code[20])
        {
            Caption = 'Attached to Doc. No.';
        }
        field(8004091; "Attached to Doc. Type"; Option)
        {
            Caption = 'Attached to Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004092; "Vendor Disc. Group"; Code[10])
        {
            Caption = 'Vendor Discount Group';
            TableRelation = "Vendor Discount Group";
        }
        field(8004093; "Remaining to Order"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       "Ordered Line" = filter(false),
                                                       Type = filter(> " ")));
            Caption = 'Remaining to Order';
            FieldClass = FlowField;
        }
        field(8004094; "Price Offer Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("No.")));
            Caption = 'Amount Excl. VAT';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {

        key(Key10; "Pay-to Vendor No.")
        {
        }

        /*GL2024  key(Key11;"Job No.","Document Type","Buy-from Vendor No.","No.")
          {
          }*/
        key(Key12; "Attached to Doc. Type", "Attached to Doc. No.")
        {
        }

        key(Key13; "Posting Date")
        {
        }
        key(Key14; Synchronise)
        {
        }

        /*GL2024 key(Key15;"Document Type","Etat Commande","Posting Date","Buy-from Vendor No.","Purchaser Code","Ship-to Address")
        {
        }*/

        key(Key16; "Due Date")
        {
        }
        key(Key17; "User ID")
        {
        }
        key(Key18; "N° Decharge")
        {
        }
        key(Key19; "N° Demande d'achat")
        {
        }
    }


    trigger OnInsert()
    var

    begin
        "Date Saisie" := Today;
        "Utilisateur" := UserId;
        if rec."Document Type" = Rec."Document Type"::Invoice then
            Rec."Apply Stamp fiscal" := true;
    end;

    trigger OnBeforeInsert()
    VAR
        lRespCenter: Record "Responsibility Center";
        lJob: Record Job;
    begin

        PurchSetup.GET;
        //AGENCE
        //#7814
        IF GETFILTER("Job No.") <> '' THEN
            IF lJob.GET(GETFILTER("Job No.")) AND (lJob."Responsibility Center" <> '') THEN
                "Responsibility Center" := lJob."Responsibility Center";
        //#7814//
        IF (UserMgt.GetSalesFilter() = '') AND lRespCenter.READPERMISSION AND lRespCenter.FIND('-') AND
           NOT HideValidationDialog THEN BEGIN
            COMMIT;
            IF page.RUNMODAL(0, lRespCenter) = ACTION::LookupOK THEN
                "Responsibility Center" := lRespCenter.Code;
        END;
        //AGENCE//

    end;

    trigger OnAfterDelete()
    var
        lMaskMgt: Codeunit "Mask Management";
    begin
        //MASK
        "Mask Code" := lMaskMgt.UserMask;
        //MASK//
        // >> HJ DSFT 31-0&-2013
        //RecJob.SETRANGE("Affaire Par Defaut",TRUE);
        //IF RecJob.FINDFIRST THEN VALIDATE("Job No.",RecJob."No.");
        // >> HJ DSFT 31-0&-2013
        IF "Document Type" = "Document Type"::Quote THEN BEGIN
            VALIDATE("Posting Date", TODAY);
            VALIDATE("Order Date", TODAY);
        END;
        "Date Saisie" := TODAY;
    end;



    trigger OnModify()
    begin
        //+ABO+
        fSubscrIntegration(0);
        //+ABO+//
    end;



    trigger OnBeforeDelete()
    var
        lOfferHeader: Record "Purchase Header";
        lOfferLine: Record "Purchase Line";
    begin
        //  IF Status > Status::Open THEN ERROR(Text052);
        // IF UserSetup.GET(UPPERCASE(USERID)) THEN IF NOT UserSetup."Supp Doc Achat" THEN ERROR(Text053);
        //+ABO+
        fSubscrIntegration(-1);
        //+ABO+//


        //+OFF+OFFRE
        IF "Document Type" = "Document Type"::Quote THEN BEGIN
            lOfferHeader.SETCURRENTKEY("Attached to Doc. Type", "Attached to Doc. No.");
            lOfferHeader.SETRANGE("Attached to Doc. Type", "Document Type");
            lOfferHeader.SETRANGE("Attached to Doc. No.", "No.");
            IF lOfferHeader.FIND('-') THEN BEGIN
                IF NOT HideValidationDialog THEN
                    IF NOT CONFIRM(STRSUBSTNO(Text8004090, "No."), FALSE) THEN
                        ERROR(Text8004091);
                REPEAT
                    lOfferLine.SETRANGE("Document Type", lOfferHeader."Document Type");
                    lOfferLine.SETRANGE("Document No.", lOfferHeader."No.");
                    lOfferLine.DELETEALL(FALSE);
                    lOfferHeader.DELETE(FALSE);
                UNTIL lOfferHeader.NEXT = 0;
            END;
        END;
        //+OFF+OFFRE//

    end;

    procedure fSubscrIntegration(pFieldNo: Integer)
    begin
        //+ABO+
        if (gLicensePermission."Object Type" <> gLicensePermission."object type"::Codeunit) or
           (gLicensePermission."Object Number" <> Codeunit::"Purch. Subscription Integr.") then
            gLicensePermission.Get(gLicensePermission."object type"::Codeunit, Codeunit::"Purch. Subscription Integr.");
        if gLicensePermission."Execute Permission" <> 0 then
            case pFieldNo of
                0:
                    gSubscrIntegration.HeaderOnModify(xRec, Rec);
                -1:
                    gSubscrIntegration.HeaderOnDelete(Rec);
                else
                    gSubscrIntegration.HeaderOnValidate(xRec, Rec, pFieldNo);
            end;
        //+ABO+//
    end;

    procedure wPostingDescription(): Text[100]
    var
        lNaviBatSetup: Record NavibatSetup;
    begin
        //POSTING_DESC
        lNaviBatSetup.GET();
        exit(lNaviBatSetup."Purchase Document Description");
        //POSTING_DESC//
    end;

    procedure wShowPostingDescription(pFormule: Text[100]): Text[100]
    var
        lRecordRef: RecordRef;
        lBasic: Codeunit Basic;
        lGenJnlLine: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lJob: Record Job;
        lFormula: Text[250];
    begin
        //POSTING_DESC
        //#RTC -- 2009
        lFormula := pFormule;
        //#RTC -- 2009//
        lRecordRef.GetTable(Rec);
        if "Document Type" in ["document type"::Quote, "document type"::Order, "document type"::Invoice, "document type"::"Blanket Order"]
        then
            lGenJnlLine."Document Type" := lGenJnlLine."document type"::Invoice
        else
            lGenJnlLine."Document Type" := lGenJnlLine."document type"::"Credit Memo";
        lFormula := lBasic.StrReplace(lFormula, '%0', Format(lGenJnlLine."Document Type"), false, false);

        //#7511
        if StrPos(lFormula, '%' + Format(Database::"Purchase Header") + '.') > 0 then begin
            lRecordRef.GetTable(Rec);
            lBasic.SubstituteValues(lFormula, lRecordRef, '%' + Format(Database::"Purchase Header") + '.', GlobalLanguage);
        end;
        if StrPos(lFormula, '%' + Format(Database::Vendor) + '.') > 0 then begin
            if lVendor.Get("Buy-from Vendor No.") then;
            lRecordRef.GetTable(lVendor);
            lBasic.SubstituteValues(lFormula, lRecordRef, '%' + Format(Database::Vendor) + '.', GlobalLanguage);
        end;
        if StrPos(lFormula, '%' + Format(Database::Job) + '.') > 0 then begin
            if lJob.Get("Job No.") then;
            lRecordRef.GetTable(lJob);
            lBasic.SubstituteValues(lFormula, lRecordRef, '%' + Format(Database::Job) + '.', GlobalLanguage);
        end;
        //#7511

        lBasic.SubstituteValues(lFormula, lRecordRef, '%', GlobalLanguage);
        //#RTC -- 2009
        if (StrLen(lFormula) > MaxStrLen(pFormule)) then
            pFormule := CopyStr(lFormula, 1, MaxStrLen(pFormule))
        else
            pFormule := lFormula;
        //#RTC -- 2009//
        exit(pFormule);
        //POSTING_DESC//*/
    end;

    procedure wGetSalutation(pFieldNo: Integer; pCode: Code[20]): Text[30]
    var
        lCust: Record Customer;
        lJob: Record Job;
        lContact: Record Contact;
        lContactName: Text[30];
    begin
        //CRM
        case pFieldNo of
            FieldNo("Ship-to Job No."):
                begin
                    lJob.Get(pCode);
                    if lCust.Get(lJob."Bill-to Customer No.") then begin
                        if lContact.Get(lCust."Primary Contact No.") then
                            lContactName := CopyStr(
                              lContact.GetSalutation(1, "Language Code"), 1, MaxStrLen(lContactName))
                        else
                            lContactName := lContact.Name;
                    end;
                end;
            FieldNo("Sell-to Customer No."):
                begin
                    if lCust.Get("Sell-to Customer No.") then begin
                        if lContact.Get(lCust."Primary Contact No.") then
                            lContactName := CopyStr(
                              lContact.GetSalutation(1, "Language Code"), 1, MaxStrLen(lContactName))
                        else
                            lContactName := lCust.Contact;
                    end;
                end;
        end;
        exit(lContactName);
        //CRM//
    end;

    procedure fCompletelyInvoiced(pPurchHeader: Record "Purchase Header"): Boolean
    var
        lPurchLine: Record "Purchase Line";
    begin
        //+REF+SOLDE_CDE
        lPurchLine.Reset;
        lPurchLine.SetRange("Document Type", pPurchHeader."Document Type");
        lPurchLine.SetRange("Document No.", pPurchHeader."No.");
        lPurchLine.SetFilter("Qty. Rcd. Not Invoiced", '<>0');
        exit(lPurchLine.IsEmpty);
        //+REF+SOLDE_CDE//
    end;

    procedure fShowDocumentInteraction(pRec: Record "Purchase Header")
    var
        lInteractionLogForm: page "Interaction Log Entries";
        lInteractionLogEntry: Record "Interaction Log Entry";
        lInteractionDocType: Option " ","Sales Qte.","Sales Blnkt. Ord","Sales Ord. Cnfrmn.","Sales Inv.","Sales Shpt. Note","Sales Cr. Memo","Sales Stmnt.","Sales Rmdr.","Serv. Ord. Create","Serv. Ord. Post","Purch.Qte.","Purch. Blnkt. Ord.","Purch. Ord.","Purch. Inv.","Purch. Rcpt.","Purch. Cr. Memo","Cover Sheet",Sale;
        lPriceOfferSetup: Record "Price Offer Setup";
    begin
        //+REF+CRM
        //lInteractionLogEntry.SETCURRENTKEY("Sales Document Type","Sales Document No.");
        case pRec."Document Type" of
            "document type"::Quote:
                lInteractionLogEntry.SetRange("Document Type", lInteractionLogEntry."document type"::"Purch.Qte.");
            "document type"::Order:
                lInteractionLogEntry.SetRange("Document Type", lInteractionLogEntry."document type"::"Purch. Ord.");
            "document type"::Invoice:
                lInteractionLogEntry.SetRange("Document Type", lInteractionLogEntry."document type"::"Purch. Inv.");
            "document type"::"Credit Memo":
                lInteractionLogEntry.SetRange("Document Type", lInteractionLogEntry."document type"::"Purch. Cr. Memo");
        end;
        //NAVIBAT
        if not lPriceOfferSetup.Get or (pRec."Buy-from Vendor No." <> lPriceOfferSetup."Default Quote Vendor") then
            lInteractionLogEntry.SetRange("Document No.", pRec."No.")
        else
            lInteractionLogEntry.SetFilter("Document No.", '%1|%2', pRec."No.", pRec."No." + '-*');
        //NAVIBAT//
        Clear(lInteractionLogForm);
        lInteractionLogForm.fSetFromSalesDoc(true);
        lInteractionLogForm.SetTableview(lInteractionLogEntry);
        lInteractionLogForm.Run;
        //+REF+CRM//
    end;

    procedure fCreateInteraction(pVendorNo: Code[20]; pPurchaseNo: Code[20])
    var
        lContactBusinessRelation: Record "Contact Business Relation";
        lSegLine: Record "Segment Line" temporary;
        lContact: Record Contact;
    begin
        //+REF+ACHAT_SUIVI
        lContactBusinessRelation.SetRange("No.", pVendorNo);
        lContactBusinessRelation.SetRange("Business Relation Code", 'FOURN');
        if not lContactBusinessRelation.Find('-') then
            Error(tContactEmpty);

        lSegLine.DeleteAll;
        lSegLine.Init;
        //IF Type = Type::Person THEN
        //  lSegLine.SETRANGE("Contact Company No.","Company No.");
        lSegLine.SetRange("Contact No.", lContactBusinessRelation."Contact No.");
        lSegLine.Validate("Contact No.", lContactBusinessRelation."Contact No.");
        lSegLine."Salesperson Code" := "Purchaser Code";
        lSegLine.Validate(Date, WorkDate);
        lSegLine."Document No." := pPurchaseNo;
        lSegLine."Document Type" := lSegLine."document type"::"Purch. Ord.";
        lSegLine.Description := StrSubstNo(tFollowUpText, "Document Type", pPurchaseNo);
        lSegLine.Insert;

        if (lContact.Get(lContactBusinessRelation."Contact No.")) then
            lSegLine.CreateSegLineInteractionFromContact(lContact);
        //PAGE.RunModal(page::"Create Interaction",lSegLine,lSegLine."Interaction Template Code");
        //+REF+ACHAT_SUIVI//
    end;

    procedure wBuyFromContactLookUp()
    var
        Cont: Record Contact;
        ContBusinessRelation: Record "Contact Business Relation";
    begin
        if ("Buy-from Vendor No." <> '') and (Cont.Get("Buy-from Contact No.")) then
            Cont.SetRange("Company No.", Cont."Company No.")
        else
            if "Buy-from Vendor No." <> '' then begin
                ContBusinessRelation.Reset;
                ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Vendor);
                ContBusinessRelation.SetRange("No.", "Buy-from Vendor No.");
                if ContBusinessRelation.Find('-') then
                    Cont.SetRange("Company No.", ContBusinessRelation."Contact No.");
            end else
                Cont.SetFilter("Company No.", '<>''''');

        if "Buy-from Contact No." <> '' then
            if Cont.Get("Buy-from Contact No.") then;
        if page.RunModal(0, Cont) = Action::LookupOK then begin
            xRec := Rec;
            Validate("Buy-from Contact No.", Cont."No.");
        end;
    end;

    procedure "HJ DSFT"()
    begin
    end;

    procedure UpdateLine()
    var
        RecLPurchaseLine: Record "Purchase Line";
        RecLItemCharAssign: Record "Item Charge Assignment (Purch)";
    begin
        //>> TRANSIT : --Dossier Arrivage--
        //>> * Mise à jour des lignes Achat
        //>> * Mise à jour des lignes Affect. frais annexes (achat)

        RecLPurchaseLine.Reset;
        RecLPurchaseLine.SetRange(RecLPurchaseLine."Document Type", "Document Type");
        RecLPurchaseLine.SetRange(RecLPurchaseLine."Document No.", "No.");
        if RecLPurchaseLine.Find('-') then begin
            repeat
                RecLPurchaseLine."N° Dossier" := "N° Dossier";
                //MBY 09/03/2011
                RecLPurchaseLine."Order Date" := "Order Date";
                //MBY 09/03/2011
                RecLPurchaseLine.Modify;
            until RecLPurchaseLine.Next = 0;
        end;

        RecLItemCharAssign.Reset;
        RecLItemCharAssign.SetRange(RecLItemCharAssign."Document Type", "Document Type");
        RecLItemCharAssign.SetRange(RecLItemCharAssign."Document No.", "No.");
        if RecLItemCharAssign.Find('-') then begin
            repeat
                RecLItemCharAssign."N° Dossier" := "N° Dossier";
                /*RecLItemCharAssign."Code devise":= "Currency Code";
                RecLItemCharAssign."Facteur Devise":= "Currency Factor";
                IF "Currency Factor" <> 0 THEN
                  RecLItemCharAssign."Montant associé DS":= RecLItemCharAssign."Montant associé"*(1/"Currency Factor")
                ELSE
                  RecLItemCharAssign."Montant associé DS":= RecLItemCharAssign."Montant associé";*/
                RecLItemCharAssign.Modify;
            until RecLItemCharAssign.Next = 0;
        end;

    end;



















    var



        UserMgt: Codeunit "User Setup Management";


        Text051: label 'Récuperer Les Articles de La DA ?';
        Text052: label 'Commande Lancé, Supression Impossible';
        Text053: label 'Vous n''Avez Pas Le Droit De Supprimer Les Commandes Consulter Votre Administrateur';
        Text054: label 'N° BL Deja Saisie !!!!!';
        Text055: label 'Impossible De Changer Le Magasin Demande Achat Lié';
        Text056: label 'N° FACTURE  Deja Saisie !!!!!';
        Text057: label 'N° FACTURE  Deja Saisie Dans Les Factures Enregestrées!!!!!';
        Text058: label 'Modification Impossible, Car Impression Lancé';
        Text059: label 'Erreur, Vous ne pouvez pas entrer une Commande dont la date est suppérieur à la date de jour !!!';
        tContactEmpty: label 'No contact found for this Vendor !';
        tFollowUpText: label '%1 No. %2';
        gLicensePermission: Record "License Permission";
        gSubscrIntegration: Codeunit "Purch. Subscription Integr.";
        Text8004090: label 'Related offers will be deleted\\Do you confirm ?';
        Text8004091: label 'The delete has been interrupted to respect the warning.';
        DtaMgt: Codeunit DtaMgt;
        RecJob: Record Job;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchaseLigne: Record "Purchase Line";
        UserSetup: Record "User Setup";
        RecPurchaseHeaderFact: Record "Purchase Header";
        RecPurchInvHeaderFact: Record "Purch. Inv. Header";
        "CUPurch.-Post": Codeunit PurchPostEvent;
        //  RecCopieEntetAchat: Record "Copie Table Entet Achat";
        //   Mail: Codeunit "Soroubat cdu";
        SalesContributor: Record "Sales Contributor";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PaymentMethod: Record "Payment Method";


}

