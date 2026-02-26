TableExtension 50017 "Sales HeaderEXT" extends "Sales Header"
{
    //GL2024  LookupPageId = "NaviBat Sales List";
    //GL2024    DrillDownPageId = "NaviBat Sales List";
    fields
    {

        modify("Sell-to Customer No.")
        {
            Description = 'Modification TableRelation';
            TableRelation = if ("Document Type" = const(Quote),
                                "Order Type" = const(" "),
                                "Bill-to Customer Templ. Code" = filter('')) Customer
            else
            if ("Document Type" = const(Quote),
                                         "Order Type" = const(" "),
                                         "Bill-to Customer Templ. Code" = filter(<> '')) Customer where("Customer Posting Group" = field("Customer Posting Group"),
                                                                                                        "Gen. Bus. Posting Group" = field("Gen. Bus. Posting Group"),
                                                                                                        "Customer Disc. Group" = field("Customer Disc. Group"),
                                                                                                        "VAT Bus. Posting Group" = field("VAT Bus. Posting Group"))
            else
            Customer;

            trigger OnafterValidate()
            var
                Cust: record customer;
            begin
                //#4337
                if cust.get(rec."Sell-to Customer No.") then;

                IF Cust."Primary Contact No." <> '' THEN
                    VALIDATE("Ship-to Contact No.", Cust."Primary Contact No.");
                //#4337//
                //CRM
                wUpdateContactCompanyNo;
                //CRM//
                // //>>DSFT-TRIUM 01/06/2009
                // if rec."Document Type" <> Rec."Document Type"::Order then begin
                //     IF RecLCustomerPostingGroup.GET("Customer Posting Group") THEN BEGIN
                //         "Apply Stamp fiscal" := RecLCustomerPostingGroup."Apply Stamp fiscal";
                //         //"Apply Fodec":= RecLCustomerPostingGroup."Apply Fodec";
                //     END;
                // end;
                // //<<DSFT-TRIUM 01/06/2009

                // // MH SORO 28-08-2020

                // IF (RecUserSetup."Prix CMDV TTC" = TRUE) AND ("Document Type" = 1) THEN Rec.VALIDATE("Prices Including VAT", TRUE);

                // // MH SORO 28-08-2020
                //GL2024
                rec."Posting Description" := Format(rec."Document Type") + ' ' + Format(rec."Sell-to Customer Name");
                //GL2024
            end;

        }

        modify("Ship-to Address")
        {
            Caption = 'Ship-to Address';
        }
        modify("Ship-to Address 2")
        {
            Caption = 'Ship-to Address 2';
        }
        modify("Ship-to City")
        {
            Caption = 'Ship-to City';
        }
        modify("Ship-to Contact")
        {
            Caption = 'Ship-to Contact';
        }


        modify("Ship-to Country/Region Code")
        {
            Caption = 'Ship-to Country/Region Code';
        }


        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                //#3985
                //IF "No." <> xRec."No." THEN BEGIN
                IF ("No." <> xRec."No.") OR ("No." = '') THEN BEGIN
                    //COMMANDE_INT
                    CASE "Order Type" OF
                        "Order Type"::"Supply Order":
                            BEGIN
                                wNaviBatSetup.GET;
                                NoSeriesMgt.TestManual(GetNoSeriesCode);
                                "No. Series" := '';
                            END;
                        //COMMANDE_INT//
                        //CESSION
                        "Order Type"::Transfer:
                            BEGIN
                                NoSeriesMgt.TestManual(GetNoSeriesCode);
                                "No. Series" := '';
                            END;
                        ELSE BEGIN
                            //#3985//
                            SalesSetup.GET;
                            NoSeriesMgt.TestManual(GetNoSeriesCode);
                            "No. Series" := '';
                        END;
                    //#3985
                    END;
                END;
                //#3985//
            end;
        }

        modify("Bill-to Customer No.")
        {
            trigger OnBeforeValidate()
            begin
                //NOMADE
                IF "Document Type" <> "Document Type"::Quote THEN
                    TESTFIELD("Bill-to Customer No.");
                //NOMADE//
            end;
        }

        modify("Ship-to Code")
        {
            trigger OnafterValidate()
            var

                lContact: Record Contact;
            begin
                //DEVIS
                IF ("Sell-to Customer No." = '') AND ("Sell-to Contact No." <> '') AND ("Document Type" = "Document Type"::Quote) THEN BEGIN
                    lContact.GET("Sell-to Contact No.");
                    //#4337
                    IF lContact."Company No." <> '' THEN
                        lContact.GET(lContact."Company No.");
                    //#4337//
                    //#6560
                    //IF ("Job No." = '') THEN
                    //  "Ship-to Name" := lContact.Name;
                    //#6560//
                    "Ship-to Name 2" := lContact."Name 2";
                    "Ship-to Address" := lContact.Address;
                    "Ship-to Address 2" := lContact."Address 2";
                    "Ship-to City" := lContact.City;
                    "Ship-to Post Code" := lContact."Post Code";
                    "Ship-to County" := lContact.County;
                    "Ship-to Country/Region Code" := lContact."Country/Region Code";
                END;
                //DEVIS//
            end;

        }

        modify("Ship-to Name")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                VALIDATE(Subject);
                //DEVIS//
            END;

        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            begin
                //#6737
                fCtrlModifShortCutDim(Rec.FIELDNO("Shortcut Dimension 1 Code"));
                //#6737//
            end;
        }

        modify("Shortcut Dimension 2 Code")
        {
            trigger OnBeforeValidate()
            begin
                //#6737
                fCtrlModifShortCutDim(Rec.FIELDNO("Shortcut Dimension 2 Code"));
                //#6737//
            end;
        }

        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            begin
                //PROJET
                wSynchroJob;
                //PROJET//
            end;
        }


        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Name" = '' THEN
                        VALIDATE("Ship-to Name", "Sell-to Customer Name");
                    IF "Bill-to Name" = '' THEN
                        "Bill-to Name" := "Sell-to Customer Name";
                END;
                //DEVIS//
            end;
        }

        modify("Sell-to Customer Name 2")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Name 2" = '' THEN
                        "Ship-to Name 2" := "Sell-to Customer Name 2";
                    IF "Bill-to Name 2" = '' THEN
                        "Bill-to Name 2" := "Sell-to Customer Name 2";
                END;
                //DEVIS//
            end;
        }

        modify("Sell-to Address")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Address" = '' THEN
                        "Ship-to Address" := "Sell-to Address";
                    IF "Bill-to Address" = '' THEN
                        "Bill-to Address" := "Sell-to Address";
                END;
                //DEVIS//
            end;
        }

        modify("Sell-to Address 2")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Address 2" = '' THEN
                        "Ship-to Address 2" := "Sell-to Address 2";
                    IF "Bill-to Address 2" = '' THEN
                        "Bill-to Address 2" := "Sell-to Address 2";
                END;
                //DEVIS//
            end;
        }

        modify("Sell-to City")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to City" = '' THEN
                        "Ship-to City" := "Sell-to City";
                    IF "Bill-to City" = '' THEN
                        "Bill-to City" := "Sell-to City";
                END;
                //DEVIS//
            end;
        }

        modify("Sell-to Contact")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Contact" = '' THEN
                        "Ship-to Contact" := "Sell-to Contact";
                    IF "Bill-to Contact" = '' THEN
                        "Bill-to Contact" := "Sell-to Contact";
                END;
                //DEVIS//
            end;
        }

        modify("Sell-to Post Code")
        {
            trigger OnAfterValidate()
            begin

                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Post Code" = '' THEN
                        VALIDATE("Ship-to Post Code", "Sell-to Post Code");
                    IF "Bill-to Post Code" = '' THEN
                        VALIDATE("Bill-to Post Code", "Sell-to Post Code");
                END;
                //DEVIS//
            end;
        }


        modify("Ship-to Post Code")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                IF "Sell-to Customer Templ. Code" <> '' THEN BEGIN
                    IF "Ship-to Country/Region Code" = '' THEN
                        "Ship-to Country/Region Code" := "Sell-to Country/Region Code";
                    IF "Bill-to Country/Region Code" = '' THEN
                        "Bill-to Country/Region Code" := "Sell-to Country/Region Code";
                END;
                //DEVIS//
            end;
        }


        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Document Date"));
                //+ABO+//
                //DEVIS
                VALIDATE("Deadline Code");
                //DEVIS//
            end;
        }

        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var

                lCustLedgEntry: Record "Cust. Ledger Entry";
                lSalesHeader: Record "Sales Header";
            begin
                //DEVIS
                IF "External Document No." = '' THEN
                    EXIT;
                IF "Bill-to Customer No." <> '' THEN BEGIN
                    lCustLedgEntry.RESET;
                    lCustLedgEntry.SETCURRENTKEY("External Document No.");
                    //lCustLedgEntry.SETRANGE("Document Type","Document Type");
                    lCustLedgEntry.SETRANGE("External Document No.", "External Document No.");
                    lCustLedgEntry.SETRANGE("Customer No.", "Sell-to Customer No.");
                    IF lCustLedgEntry.FIND('-') THEN
                        ERROR(
                          tExternalDocExists,
                          lCustLedgEntry."Document Type", "External Document No.");
                END;

                lSalesHeader.RESET;
                lSalesHeader.SETRANGE("External Document No.", "External Document No.");
                lSalesHeader.SETRANGE("Sell-to Contact No.", "Sell-to Contact No.");
                //lSalesHeader.SETRANGE("Sell-to Customer No.","Sell-to Customer No.");
                lSalesHeader.SETFILTER("No.", '<>%1', "No.");
                IF lSalesHeader.FIND('-') THEN
                    ERROR(
                      tExternalDocExists,
                      lSalesHeader."Document Type", "External Document No.");
                //DEVIS//
            end;
        }
        modify("Shipping Advice")
        {
            trigger OnAfterValidate()
            var
            begin
                WhseSourceHeader.SalesHeaderVerifyChange(Rec, xRec);
            end;


        }

        modify("VAT Bus. Posting Group")
        {
            trigger OnAfterValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
                TestStatusOpen();
                if xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group" then begin
                    //DEVIS  RecreateSalesLines(FIELDCAPTION("VAT Bus. Posting Group"));
                    BEGIN
                        lSalesLine.SETRANGE("Document Type", "Document Type");
                        lSalesLine.SETRANGE("Document No.", "No.");
                        IF lSalesLine.FIND('-') THEN
                            REPEAT
                                lSalesLine."VAT Bus. Posting Group" := "VAT Bus. Posting Group";
                                IF lSalesLine.Type <> lSalesLine.Type::" " THEN
                                    lSalesLine.VALIDATE("VAT Bus. Posting Group");
                                lSalesLine.MODIFY;
                            UNTIL lSalesLine.NEXT = 0;
                    END;
                    //DEVIS//
                end;
            end;
        }

        /*GL2024 modify(Status)
          {
            Editable=true;
          }*/

        modify("Prepayment %")
        {
            trigger OnAfterValidate()
            begin
                //+ONE+PREPAYMENT
                IF "Invoicing Method" = "Invoicing Method"::Completion THEN
                    "Prepayment %" := 0;
                //+ONE+PREPAYMENT//
            end;
        }

        modify("Compress Prepayment")
        {
            trigger OnbeforeValidate()
            begin
                //#7849
                IF "Invoicing Method" = "Invoicing Method"::Completion THEN
                    "Compress Prepayment" := FALSE;
                //#7849//
            end;
        }

        modify("Sell-to Contact No.")
        {
            trigger OnafterValidate()
            var


                Cont: Record Contact;
            begin
                //CRM
                wUpdateContactCompanyNo;
                //CRM//

                //+REF+CRM
                IF ("Sell-to Customer No." = '') AND
                   ("Sell-to Contact No." <> '') AND
                   ("Document Type" = "Document Type"::Quote)
                THEN BEGIN
                    Cont.GET("Sell-to Contact No.");
                    IF Cont."Sell-to Customer Template Code" <> '' THEN
                        VALIDATE("Sell-to Customer Templ. Code", Cont."Sell-to Customer Template Code");
                    //DEVIS
                    VALIDATE("Ship-to Code");
                    //DEVIS//
                END;
                //+REF+CRM//
            end;
        }

        modify("Responsibility Center")
        {
            trigger OnbeforeValidate()
            var


                Text010: label 'Voulez-vous continuer?';
            begin
                TestStatusOpen();
                //AGENCE
                IF (xRec."Responsibility Center" <> "Responsibility Center") AND NOT InsertMode THEN
                    IF NOT CONFIRM(
                              TextRespCenter +
                              Text010,
                              FALSE,
                              FIELDCAPTION("Responsibility Center")) THEN
                        ERROR('');
                //AGENCE//
                //PERF
                lSingleinstance.wSetSalesHeader(Rec);
                //PERF//
            end;
        }

        field(50000; "Critére Eval Fournisseur"; Option)
        {
            OptionCaption = 'Prix,Delai,Note';
            OptionMembers = Prix,Delai,Note;
        }
        field(50001; "Requester ID"; Text[30])
        {
            Caption = 'ID Demandeur';
            Description = '// DDE D''APPRO';
            Editable = true;
            TableRelation = Demandeur;

            trigger OnLookup()
            begin
                // if page.RunModal(page::"Liste Utilisateurs", Demandeur) = Action::LookupOK then "Requester ID" := Demandeur."Nom Et Prenom";
            end;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50002; Service; Option)
        {
            Description = '// DDE D''APPRO';
            OptionMembers = ,"Parc Taabo",Lot1,"Lot3.2","Lot1.2","Lot1.1",Lot2,"Directeion Gen","Dir Audit","Dir Cpt Et Admin","Dir Finaciere","Controle Et Gestion",Appro,Secreteriat,BaseViee;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50003; "Type Demande"; Option)
        {
            Description = '// DDE D''APPRO';
            OptionCaption = 'Pièce de Rechange,Materiaux,Fourniture et Divers,Prestation de Service';
            OptionMembers = "Pièce de Rechange",Materiaux,"Fourniture et Divers","Prestation de Service";
        }
        field(50004; Synchronise; Boolean)
        {
        }
        field(50005; "Num Sequence Syncro"; Integer)
        {
        }
        field(50006; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Appliquer Timbre Fiscal';
            Description = 'STD V1.0';
            InitValue = false;
        }
        field(50015; Approbateur; Code[10])
        {
            Description = '// DDE D''APPRO';
        }
        field(50016; "Date approbation"; Date)
        {
            Description = '// DDE D''APPRO';
        }
        field(50017; Approval; Option)
        {
            Caption = 'Approval';
            Description = '// DDE D''APPRO';
            OptionCaption = 'Pending,accepted,refused';
            OptionMembers = "En attente","Accepté","Refusé";

            trigger OnValidate()
            var
                RecPurchaseSetup: Record "Purchases & Payables Setup";
                RecItem: Record Item;
                RecSalesLine: Record "Sales Line";
            begin

                if RecPurchaseSetup.Get() then begin
                    if RecPurchaseSetup."Enable Approval Requisition" then begin

                        // IF RecPurchaseSetup."Enable threshold approval req" THEN
                        if verifDemandeApprobation(UserId, Rec) = true then begin
                            RecSalesLine.SetRange("Document No.", "No.");
                            RecSalesLine.SetRange(Type, 2);

                            Approber := TRUE;
                            Validate(Approber);
                            Approbateur := UserId;
                            "Date approbation" := Today;
                            Modify;

                        end else begin

                            Approber := false;
                            Validate(Approber);
                            Approbateur := UserId;
                            "Date approbation" := Today;
                            Modify;

                        end;


                    end;
                end;
            end;
        }
        field(50018; Approber; Boolean)
        {
            Description = '// DDE D''APPRO';

            trigger OnValidate()
            var
                RecSalesLine: Record "Sales Line";
                Text0002: label 'Code Magasin Doit Etre Renseigner Pour Article %1';
            begin
                // >> HJ 05-04-2018
                // SalesContributor.SetRange("Job No.", "Job No.");
                // SalesContributor.SetRange(Approbateur, UpperCase(UserId));
                // //IF NOT  SalesContributor.FINDFIRST THEN ERROR(Text071,UPPERCASE(USERID));          KA 17/08/2020
                // Approbateur := UserId;
                // "Date approbation" := Today;
                // Modify;

                // >> HJ 05-04-2018


                RecSalesLine.Reset;
                RecSalesLine.SetRange("Document Type", "Document Type");
                RecSalesLine.SetRange("Document No.", "No.");
                RecSalesLine.SetFilter(Type, '<>%1', 0);
                if not RecSalesLine.Find('-') then Error(Text090);

                RecSalesLine.Reset;
                RecSalesLine.SetRange("Document Type", "Document Type");
                RecSalesLine.SetRange("Document No.", "No.");
                RecSalesLine.SetFilter(Type, '<>%1', 0);
                if RecSalesLine.Find('-') then begin
                    repeat
                    begin
                        if RecSalesLine.Type = RecSalesLine.Type::Item then
                            IF RecSalesLine."Location Code" = '' THEN ERROR(Text0002, RecSalesLine."No.");

                    end;
                    until RecSalesLine.Next = 0;
                    /*perm.RESET;
                                                                                  IF perm.GET(USERID,'ACH-DA-VISA',COMPANYNAME) OR perm.GET(USERID,'SUPER') THEN
                                                                                   BEGIN
                                                                                      "Vis‚ Par" := USERID;
                                                                                      MODIFY;
                                                                                   END ELSE
                                                                                   BEGIN
                                                                                    "Visa CSA" := xRec."Visa CSA";
                                                                                     MODIFY;
                                                                                     ERROR('Vous n''avez pas les autorisations n‚cessaires pour modifier ce champs. \\'+
                                                                                     'Contactez votre administrateur pour mettre … jour vos autorisations!');

                                                                                   END;*/
                end;
            end;
        }
        field(50019; Engin; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                if Véhicule.Get(Engin) then begin
                    "Description Engin" := CopyStr(Véhicule.Désignation, 1, 50);
                    "N° Serie" := Véhicule."No. Series";
                    Type := Véhicule.Marque;
                    "Sous Famille Engin" := Véhicule."Sous Famille";
                end;
            end;
        }
        field(50020; Type; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50021; "N° Serie"; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50022; "Description Engin"; Text[50])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50023; "Receptionné"; Boolean)
        {
            Description = 'HJ SORO 16-10-2014';
        }
        field(50024; "Commande Achat Associé"; Code[20])
        {
            CalcFormula = lookup("Purchase Header"."No." where("N° Demande d'achat" = field("No."),
                                                                "Document Type" = const(Order)));
            Description = 'HJ SORO 23-02-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Jours Retard"; Integer)
        {
            Description = 'HJ SORO 09-08-2016';
        }
        field(50026; "BOR DA"; Boolean)
        {
            Description = 'HJ SORO 09-08-2016';
        }
        field(90027; "N° timbre Fiscal"; Code[20])
        {

        }
        field(90028; "N° Sticker Fiscal"; Code[20])
        {

        }
        field(60009; "Compteur Engin"; Decimal)
        {
            Description = 'HJ SORO 09-08-2016';
            Editable = false;
        }
        field(60010; "Dernier Vidange"; Decimal)
        {
            Description = 'HJ SORO 09-08-2016';
            Editable = false;
        }
        field(50029; "Sous Famille Engin"; Code[50])
        {
            Description = 'HJ SORO 09-08-2016';
        }
        field(50030; "Commande Affaire"; Boolean)
        {
            Description = 'HJ SORO 18-09-2013';
        }
        field(50032; Marche; Boolean)
        {
            Description = 'HJ SORO 11-10-2016';
        }
        field(60001; "Alerte Imminente"; Boolean)
        {
            Description = 'HJ SORO 08-11-2016';
        }
        field(60002; "Alerte Imminente Desactivé"; Boolean)
        {
            Description = 'HJ SORO 08-11-2016';
        }
        field(60003; "Alerte Imminente Declanché"; Boolean)
        {
            Description = 'HJ SORO 08-11-2016';
        }
        field(60011; "N° Reparation"; Code[20])
        {
            Description = 'HJ SORO 16-11-2016';
            Editable = false;
        }
        field(60012; "Type DA"; Option)
        {
            OptionMembers = "Consultation Externe","Consultation Interne";

            trigger OnValidate()
            var
                LSalesLine: Record 37;
            begin
                LSalesLine.SETRANGE("Document Type", "Document Type");
                LSalesLine.SETRANGE("Document No.", "No.");
                IF LSalesLine.FINDFIRST THEN
                    REPEAT
                        LSalesLine."Type DA" := "Type DA";
                        LSalesLine.MODIFY;
                    UNTIL LSalesLine.NEXT = 0;
            end;
        }
        field(60013; "DA Origine"; Code[20])
        {
            Description = 'HJ SORO 21-12-2016';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
                                                      "Order Type" = CONST("Supply Order"),
                                                      Status = FILTER(<> Archivé));

            trigger OnValidate()
            var
                LSalesLine: Record 37;
                LSalesLine2: Record 37;
                TextL001: Label 'Inserer Ces Lignes ?';
            begin
                IF NOT CONFIRM(TextL001) THEN EXIT;
                LSalesLine.SETRANGE("Document Type", "Document Type");
                LSalesLine.SETRANGE("Document No.", "DA Origine");
                IF LSalesLine.FINDFIRST THEN
                    REPEAT
                        LSalesLine2.TRANSFERFIELDS(LSalesLine);
                        LSalesLine2."Document No." := "No.";
                        IF LSalesLine2.INSERT THEN;
                    UNTIL LSalesLine.NEXT = 0;
            end;
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8001301; "Criteria 1"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99090';
            Caption = 'Criteria 1';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001301));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001302; "Criteria 2"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99091';
            Caption = 'Criteria 2';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001302));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001303; "Criteria 3"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99092';
            Caption = 'Criteria 3';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001303));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001304; "Criteria 4"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99093';
            Caption = 'Criteria 4';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001304));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001305; "Criteria 5"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Criteria 5';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001305));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001306; "Criteria 6"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Criteria 6';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001306));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001307; "Criteria 7"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Criteria 7';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001307));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001308; "Criteria 8"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Criteria 8';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001308));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001309; "Criteria 9"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Criteria 9';
            Enabled = false;
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001309));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001310; "Criteria 10"; Code[20])
        {
            CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Criteria 10';
            TableRelation = Code.Code WHERE("Table No" = CONST(8004160),
                                             "Field No" = CONST(8001310));

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001400; "Financial Document"; Boolean)
        {
            Caption = 'Financial Document';
        }
        field(8001401; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            NotBlank = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit 418;
            begin
                //GL2024    LoginMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit 418;
            begin
            end;
        }
        field(8001402; "Doc. Creation Date"; Date)
        {
            Caption = 'Doc. Creation Date';
            Editable = false;
        }
        field(8001403; "Source Quote No."; Code[20])
        {
            Caption = 'Source Quote No.';
        }
        field(8001404; "Close Opportunity Code"; Code[10])
        {
            Caption = 'Close Opportunity Code';
            TableRelation = "Close Opportunity Code".Code;

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8001405; "Header comments"; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                            "No." = FIELD("No."),
                                                            "Document Line No." = CONST(-1)));
            FieldClass = FlowField;
        }
        field(8001406; "Footer comments"; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                            "No." = FIELD("No."),
                                                            "Document Line No." = CONST(-2)));
            FieldClass = FlowField;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Subscription Starting Date"));
                //+ABO+//
            end;
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Subscription End Date"));
                //+ABO+//
            end;
        }
        field(8001902; "Next Invoice Calculation"; DateFormula)
        {
            Caption = 'Next Invoice Calculation';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Next Invoice Calculation"));
                //+ABO+//
            end;
        }
        field(8001903; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            Editable = false;
        }
        field(8001905; "Invoicing Periodicity Code"; Code[20])
        {
            Caption = 'Invoicing Periodicity Code';
            TableRelation = "Subscr. Invoicing Period";

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Invoicing Periodicity Code"));
                //+ABO+//
            end;
        }
        field(8001930; "Review Formula Code"; Code[10])
        {
            Caption = 'Price Index Code';
            TableRelation = "Subscr. Review Formula";

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FIELDNO("Review Formula Code"));
                //+ABO+//
            end;
        }
        field(8001931; "Review Base Date"; Date)
        {
            Caption = 'Index Basis Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Review Base Date"));
                //+ABO+//
            end;
        }
        field(8003900; "No. Prepayment Invoiced"; Integer)
        {
            Caption = 'No. Prepayment Invoiced';

            trigger OnValidate()
            var
                lText1100280001: label '%1 must be superior to %2.';
                lText1100280002: label 'This document will not be a completion %1 any more.\';
                lText1100280003: label 'You cannot create a completion %1.';
                lText1100280004: label 'Completion %1 cannot be at %2.';
            begin
            end;
        }
        field(8003901; "Scheduler Origin"; Boolean)
        {
            Caption = 'Scheduler Origin';
            Editable = false;
        }
        field(8003902; "Order Type"; Option)
        {
            Caption = 'Order Type';
            OptionCaption = ' ,Supply Order,Transfer';
            OptionMembers = " ","Supply Order",Transfer;

            trigger OnValidate()
            begin
                if "Last Posting No." <> '' then
                    Error(Text028, FieldCaption("Order Type"), FieldCaption("Last Posting No."));

                if "Last Shipping No." <> '' then
                    Error(Text028, FieldCaption("Order Type"), FieldCaption("Last Shipping No."));
            end;
        }
        field(8003903; "Rider to Order No."; Code[20])
        {
            Caption = 'Avenant à la Cde N°';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "Sell-to Customer No." = field("Sell-to Customer No."),
                                                        "Order Type" = const(" "));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                lSalesHeader: Record "Sales Header";
                lSalesHeaderTmp: Record "Sales Header" temporary;
                lSalesHeader2: Record "Sales Header";
            begin
                /*
                IF ("Rider to Order No." = "No.") AND ("Document Type" = "Document Type"::Order) THEN
                  FIELDERROR("Rider to Order No.",tSelfRider)
                ELSE IF "Rider to Order No." <> '' THEN
                //PROJET_FACT
                //  IF CONFIRM(Text8003907,TRUE,"Rider to Order No.") THEN BEGIN
                //PROJET_FACT//
                //#4570
                    lSalesHeader2.SETCURRENTKEY("Rider to Order No.");
                    lSalesHeader2.SETRANGE("Rider to Order No.","No.");
                    IF NOT lSalesHeader2.ISEMPTY THEN
                      ERROR(tRiderToOrder);
                //#4570//
                    IF lSalesHeader.GET(lSalesHeader."Document Type"::Order,"Rider to Order No.") THEN BEGIN
                //PROJET_FACT
                      IF lSalesHeader."Rider to Order No." <> '' THEN
                        ERROR(tRiderToOrder);
                //PROJET_FACT//
                //#4516
                      wUpdateRider(lSalesHeader,Rec);
                    END;
                //PROJET_FACT
                //  END;
                //PROJET_FACT//
                */
                TestField("Document Type", "document type"::Quote);
                if "Rider to Order No." <> '' then begin
                    lSalesHeader.Get(lSalesHeader."document type"::Order, "Rider to Order No.");
                    wUpdateRider(lSalesHeader, Rec);
                    //#6097
                    Validate("Currency Factor", lSalesHeader."Currency Factor");
                    //#6097//
                end;

                if SalesLinesExist then
                    UpdateSalesLines(FieldCaption("Rider to Order No."), false);

                //#7202
                fAddBoqHeader(Rec);
                //#7202//

            end;
        }
        field(8003905; Subject; Text[50])
        {
            Caption = 'Object';

            trigger OnValidate()
            begin
                if ("Job Description" = '') or (xRec.Subject = '') or
                   (CopyStr(xRec."Ship-to Name" + ' - ' + xRec.Subject, 1, MaxStrLen("Job Description")) = "Job Description") then
                    "Job Description" := CopyStr("Ship-to Name" + ' - ' + Subject, 1, MaxStrLen("Job Description"));
            end;
        }
        field(8003906; "Invoicing Method"; Option)
        {
            Caption = 'Invoicing Method';
            OptionCaption = 'Direct,Scheduler,Completion';
            OptionMembers = Direct,Scheduler,Completion;

            trigger OnValidate()
            var
                lInvScheduler: Record "Invoice Scheduler";
                lSalesLine: Record "Sales Line";
            begin
                if "Invoicing Method" <> xRec."Invoicing Method" then begin

                    //#6388
                    "Compress Prepayment" := ("Invoicing Method" <> "invoicing method"::Completion);
                    //#6388//
                    //#5409
                    if xRec."Invoicing Method" = "invoicing method"::Completion then          // Dde acompte imprimée
                        TestField("No. Prepayment Request Printed", 0);
                    //#5409//

                    lSalesLine.Reset;                                      // Qté facturée
                    lSalesLine.SetRange("Document Type", "Document Type");
                    lSalesLine.SetRange("Document No.", "No.");
                    lSalesLine.SetFilter("Quantity Invoiced", '<>0');
                    if lSalesLine.FindFirst then
                        Error(Text8003905, FieldCaption("Invoicing Method"));

                    lSalesLine.SetRange("Quantity Invoiced");
                    lSalesLine.SetFilter("Prepmt. Amt. Inv.", '<>0');
                    if lSalesLine.FindFirst then
                        Error(Text8003905, FieldCaption("Invoicing Method"));

                    if xRec."Invoicing Method" = "invoicing method"::Scheduler then begin
                        lInvScheduler.SetRange("Sales Header Doc. Type", "Document Type");      // Echéancier facturé existe
                        lInvScheduler.SetRange("Sales Header Doc. No.", "No.");
                        lInvScheduler.SetFilter("Amount Emitted", '<>0');
                        if not lInvScheduler.IsEmpty then
                            Error(Text8003905, FieldCaption("Contract Type"))
                        else begin
                            lInvScheduler.SetRange("Amount Emitted");
                            lInvScheduler.DeleteAll(true);
                        end;
                    end;

                    if "Invoicing Method" = "invoicing method"::Direct then begin        //MAJ qté à livrer et qté à facturer
                        lSalesLine.Reset;
                        lSalesLine.SetRange("Document Type", "Document Type");
                        lSalesLine.SetRange("Document No.", "No.");
                        lSalesLine.SetRange("Structure Line No.", 0);
                        lSalesLine.SetFilter(lSalesLine."Outstanding Quantity", '<>0');
                        if lSalesLine.FindFirst then
                            repeat
                                lSalesLine.Validate("Qty. to Ship", lSalesLine."Outstanding Quantity");
                                lSalesLine.Modify;
                            until lSalesLine.Next = 0;
                    end else begin
                        lSalesLine.Reset;
                        lSalesLine.SetRange("Document Type", "Document Type");
                        lSalesLine.SetRange("Document No.", "No.");
                        lSalesLine.SetRange("Structure Line No.", 0);
                        lSalesLine.SetFilter(Quantity, '<>0');
                        if lSalesLine.FindFirst then
                            repeat
                                lSalesLine.Validate("Qty. to Ship", 0);
                                lSalesLine.Modify;
                            until lSalesLine.Next = 0;
                    end;

                end;
            end;
        }
        field(8003911; "Recognition Method"; Option)
        {
            Caption = 'Recognition Method';
            OptionCaption = 'Percentage of Completion,Completed Contract';
            OptionMembers = "Percentage of Completion","Completed Contract";
        }
        field(8003912; "Person Responsible"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003912);
            Caption = 'Person Responsible';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin

                //#7476
                lResource.SetRange(Type, lResource.Type::Person);
                lResource.SetRange(Status, lResource.Status::Internal);
                //#9065
                if ISSERVICETIER then begin
                    if page.RunModal(8035107, lResource) = Action::LookupOK then
                        "Person Responsible 3" := lResource."No.";
                end else begin
                    //#9065//
                    if page.RunModal(0, lResource) = Action::LookupOK then
                        "Person Responsible" := lResource."No.";
                    //#9065
                end;
                //#9065//
                //#7476//
            end;

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003913; "Project Manager"; Code[20])
        {
            Caption = 'Maître d''oeuvre';
            TableRelation = Contact;

            trigger OnValidate()
            var
                lContributor: Record "Sales Contributor";
                lContact: Record Contact;
            begin
                TestField(Status, Status::Open);

                //CONTRIBUTOR
                lContributor.SetRange("Document Type", "Document Type");
                lContributor.SetRange("Document No.", "No.");
                lContributor.SetRange("Line No.", 0);
                if not lContributor.Find('-') then
                    lContributor.Init
                else
                    if "Project Manager" = '' then
                        lContributor.Delete;

                if "Project Manager" <> '' then begin
                    lContact.Get("Project Manager");
                    lContributor."Document Type" := "Document Type";
                    lContributor."Document No." := "No.";
                    lContributor."Line No." := 0;
                    lContributor."Job No." := "Job No.";
                    lContributor.Validate("Contact Type", lContact.Type);
                    lContributor.Validate("Contact No.", "Project Manager");
                    lContributor.Responsability := FieldCaption("Project Manager");
                    if not lContributor.Insert then
                        lContributor.Modify;
                end;
                //CONTRIBUTOR//
            end;
        }
        field(8003915; "Amount Excl. VAT (LCY)"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Amount Excl. VAT (LCY)" where("Document Type" = field("Document Type"),
                                                                           "Document No." = field("No."),
                                                                           "Line Type" = filter(>= Item),
                                                                           "Structure Line No." = filter(0)));
            Caption = 'Montant HT (DS)';
            FieldClass = FlowField;
        }
        field(8003916; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
        }
        field(8003917; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
        }
        field(8003918; "Source Quote Occurence No."; Integer)
        {
            Caption = 'Source Quote Occurence No.';
        }
        field(8003919; "Source Quote Version No."; Integer)
        {
            Caption = 'Source Quote Version No.';
        }
        field(8003920; "Sell-to Contact Company No."; Code[20])
        {
            Caption = 'Sell-to Contact Company No.';
            TableRelation = Contact where(Type = const(Company));

            trigger OnValidate()
            var
                Opp: Record Opportunity;
                OppEntry: Record "Opportunity Entry";
                Todo: Record "To-do";
                InteractLogEntry: Record "Interaction Log Entry";
                SegLine: Record "Segment Line";
                SalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(8003921; "Ship-to Contact No."; Code[20])
        {
            Caption = 'Ship-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin


                if "Ship-to Contact No." <> '' then
                    if Cont.Get("Ship-to Contact No.") then;
                if page.RunModal(0, Cont) = Action::LookupOK then begin
                    xRec := Rec;
                    //#5478
                    UpdateShipToCust(Cont."No.");
                    //#5478

                end;
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
                TestField(Status, Status::Open);
                //#5478
                //Cont.GET("Ship-to Contact No.");
                //"Ship-to Contact" := Cont.Name

                if ("Ship-to Contact No." <> xRec."Ship-to Contact No.") and
                   (xRec."Ship-to Contact No." <> '')
                then begin
                    if HideValidationDialog then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text004, false, FieldCaption("Ship-to Contact No."));
                    if Confirmed then
                        UpdateShipToCust("Ship-to Contact No.");
                end;
                //#5478//
            end;
        }
        field(8003922; "Job Description"; Text[50])
        {
            Caption = 'Désignation affaire';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'N° affaire';
            Description = 'Modification TableRelation';
            TableRelation = IF ("Order Type" = FILTER("Supply Order" | Transfer)) Job WHERE("IC Partner Code" = CONST())
            ELSE
            Job WHERE("Job Type" = CONST(External),
                                                                                 "IC Partner Code" = CONST());


            trigger OnValidate()
            var
                lContributor: Record "Sales Contributor";
                lContributor2: Record "Sales Contributor";
                lJobStatusMgt: Codeunit "Job Status Management";
                lJobStatus: Record "Job Status";
                lTempDocDim: Record "Gen. Jnl. Dim. Filter" temporary;
                Text01: label 'Affaire non associé à aucune magasin, Contacter votre Administrateur Pour affecter l''affaire %1 à une magasin';
                "// RB SORO 14/05/2015": Integer;
                RecLocationJob: Record Location;
                DimSource: List of [Dictionary of [Integer, Code[20]]];
                DimDictionary: Dictionary of [Integer, Code[20]];
            begin
                //PROJET
                wJob.wCheckBlockedJob("Job No.");
                //PROJET//
                //JOB_STATUS
                // case "Order Type" of
                //     "order type"::" ":
                //         if "Job No." <> '' then
                //             lJobStatusMgt.Check("Job No.", lJobStatus.FieldNo(lJobStatus."Sales Document"));
                //     "order type"::"Supply Order":
                //         lJobStatusMgt.Check("Job No.", lJobStatus.FieldNo(lJobStatus."Reordering Requisition"));
                // end;
                //JOB_STATUS//
                //DEVIS

                IF ("Document Type" = "Document Type"::Order) AND
                ("Job No." <> xRec."Job No.") AND (xRec."Job No." <> '') THEN
                    FIELDERROR("Job No.", tNoChangeJob);

                if not wJob.Get("Job No.") then
                    wJob.Init;
                //#5177
                if "Currency Code" <> '' then
                    if wJob."Currency Code" <> '' then
                        TestField("Currency Code", wJob."Currency Code");
                //#5177//
                if ("Order Type" <> "order type"::"Supply Order") then begin
                    "Job Description" := wJob.Description;
                    if Subject = '' then
                        Subject := wJob.Subject;
                    if wJob."Description 2" <> '' then
                        Validate("Ship-to Name", CopyStr(wJob."Description 2", 1, MaxStrLen("Ship-to Name")));
                    if wJob."Job Address" <> '' then begin
                        "Ship-to Address" := wJob."Job Address";
                        "Ship-to Address 2" := wJob."Job Address 2";
                        "Ship-to City" := wJob."Job City";
                        "Ship-to Post Code" := wJob."Job Post Code";
                        "Ship-to Country/Region Code" := wJob."Job Country Code";
                        "Ship-to County" := wJob."Job County";
                    end;
                    if CurrFieldNo = FieldNo("Job No.") then
                        wUpdateDocFromJob;
                end;
                //DEVIS//

                //CDE_INTERNE
                if "Order Type" = "order type"::"Supply Order" then begin
                    Validate("Sell-to Customer No.", wJob."Bill-to Customer No.");
                    Validate("Ship-to Name", CopyStr(wJob."Description 2", 1, MaxStrLen("Ship-to Name")));
                    "Job Description" := wJob.Description;
                    "Ship-to Address" := wJob."Job Address";
                    "Ship-to Address 2" := wJob."Job Address 2";
                    "Ship-to City" := wJob."Job City";
                    "Ship-to Post Code" := wJob."Job Post Code";
                    "Ship-to Country/Region Code" := wJob."Job Country Code";
                    "Ship-to County" := wJob."Job County";
                end;
                //CDE_INTERNE//

                //PROJET
                //MessageIfSalesLinesExist(FIELDCAPTION("Job No."));
                if SalesLinesExist then begin
                    //PERF
                    wSingleInstance.wSetSalesHeader(SalesHeader);
                    //PERF//
                    UpdateSalesLines(FieldCaption("Job No."), CurrFieldNo <> 0);
                end else
                    //#5114
                    wUpdateSchedulerLines(FieldCaption("Job No."), false);
                //PROJET//

                //#7391
                //DYS table obsolet dans BC
                // lTempDocDim.GetDimensions(Database::"Sales Header", "Document Type", "No.", 0, lTempDocDim);
                //#7391//

                /*GL2024 CreateDim(
                   Database::Job, "Job No.",
                   Database::Customer, "Bill-to Customer No.",
                   Database::"Salesperson/Purchaser", "Salesperson Code",
                   Database::Campaign, "Campaign No.",
                   Database::"Responsibility Center", "Responsibility Center",
                   Database::"Customer Template", "Bill-to Customer Template Code");*/
                //GL2024            
                DimDictionary.Add(DATABASE::Job, "Job No.");
                DimDictionary.Add(DATABASE::Customer, "Bill-to Customer No.");
                DimDictionary.Add(DATABASE::Campaign, "Campaign No.");
                DimDictionary.Add(DATABASE::"Responsibility Center", "Responsibility Center");
                DimDictionary.Add(DATABASE::"Customer Templ.", "Bill-to Customer Templ. Code");
                DimSource.Add(DimDictionary);
                CreateDim(DimSource);
                //GL2024

                //#7391
                if ((xRec."Job No." <> "Job No.") or (xRec."Job No." = '')) and SalesLinesExist then begin
                    //#7646
                    //DYS table obsolet dans BC
                    //lTempDocDim.SetRecursiveValue(xRec."Job No." = '');
                    //#7646//
                    //lTempDocDim.UpdateAllLineDim(Database::"Sales Header", "Document Type", "No.", lTempDocDim);
                end;
                //#7391

                //PROJET_FACT
                if ("Job No." <> xRec."Job No.") and ("No. Prepayment Invoiced" <> 0) then
                    "No. Prepayment Invoiced" := 0;
                //PROJET_FACT//

                //CONTRIBUTOR
                if "Order Type" = "order type"::" " then begin
                    lContributor.SetRange("Document Type", "Document Type");
                    lContributor.SetRange("Document No.", "No.");
                    lContributor.SetFilter("Job No.", '<>%1', "Job No.");
                    if not lContributor.IsEmpty then
                        if lContributor.Find('-') then
                            repeat
                                lContributor2 := lContributor;
                                lContributor2."Job No." := "Job No.";
                                if lContributor2.Insert then;
                                lContributor.Delete;
                            until lContributor.Next = 0;
                    lContributor.Reset;
                    lContributor.SetRange("Job No.", "Job No.");
                    lContributor.SetRange("Document No.", '');
                    lContributor.SetRange("Document Type", 0);
                    if not lContributor.IsEmpty then
                        if lContributor.Find('-') then
                            repeat
                                lContributor2.Reset;
                                lContributor2.SetRange("Document Type", "Document Type");
                                lContributor2.SetRange("Document No.", "No.");
                                lContributor2.SetRange("Job No.", "Job No.");
                                lContributor2.SetRange(Contributor, lContributor.Contributor);
                                lContributor2.SetRange("Contact Type", lContributor."Contact Type");
                                lContributor2.SetRange("Contact No.", lContributor."Contact No.");
                                if not lContributor2.IsEmpty then
                                    if lContributor2.Find('-') then
                                        repeat
                                            lContributor2.Delete;
                                        until lContributor2.Next = 0;
                            until lContributor.Next = 0;
                    if xRec."Job No." <> "Job No." then begin
                        lContributor.Reset;
                        lContributor.SetRange("Job No.", xRec."Job No.");
                        lContributor.SetRange("Document No.", '');
                        lContributor.SetRange("Document Type", 0);
                        if not lContributor.IsEmpty then
                            if lContributor.Find('-') then
                                repeat
                                    lContributor2.Reset;
                                    lContributor2.SetRange("Document Type", "Document Type");
                                    lContributor2.SetRange("Document No.", "No.");
                                    lContributor2.SetRange("Job No.", "Job No.");
                                    lContributor2.SetRange(Contributor, lContributor.Contributor);
                                    lContributor2.SetRange("Contact Type", lContributor."Contact Type");
                                    lContributor2.SetRange("Contact No.", lContributor."Contact No.");
                                    if lContributor2.IsEmpty then begin
                                        lContributor2.SetRange(Contributor);
                                        lContributor2.SetRange("Contact Type");
                                        lContributor2.SetRange("Contact No.");
                                        if lContributor2.Find('+') then;
                                        lContributor2."Document Type" := "Document Type";
                                        lContributor2."Document No." := "No.";
                                        lContributor2."Job No." := "Job No.";
                                        lContributor2."Line No." += 1000;
                                        lContributor2.Contributor := lContributor.Contributor;
                                        lContributor2."Contact Type" := lContributor."Contact Type";
                                        lContributor2.Validate("Contact No.", lContributor."Contact No.");
                                        lContributor2.Insert;
                                    end;
                                until lContributor.Next = 0;
                    end;
                end;
                //CONTRIBUTOR//

                //MASK
                "Mask Code" := wJob."Mask Code";
                //MASK//

                // RB SORO 14/05/2015 LOCATION CODE WITH JOB N°
                // RecLocationJob.Reset;
                // RecLocationJob.SetRange(Affectation, "Job No.");
                // if RecLocationJob.FindLast then
                //     Validate("Location Code", RecLocationJob.Code)
                // else begin
                //     if RecJob.Get("Job No.") then
                //         if RecJob."Affectation Magasin" <> '' then
                //             Validate("Location Code", RecJob."Affectation Magasin")
                //         else
                //             Message(Text070, "Job No.");
                // end;
                // // RB SORO 14/05/2015 LOCATION CODE WITH JOB N°
            end;
        }
        field(8003924; "Part Payment"; Decimal)
        {
            Caption = 'Avance à déduire TTC';
            BlankZero = true;
        }
        field(8003925; "Contract Type"; Code[10])
        {
            Caption = 'Type de contrat';
            TableRelation = "Contract Type".Code;

            trigger OnValidate()
            var
                lContract: Record "Contract Type";
                lTextCode: array[20] of Code[10];
                lSalesTextMgt: Codeunit "Sales Text Management";
                lSalesCommentLine: Record "Sales Comment Line";
                lContractTypeOtherRes: Record "Contract Type - Other Res.";
                lSalesLine: Record "Sales Line";
                lSingleInstance: Codeunit "Import SingleInstance2";
            begin
                //PROJET_FACT
                if ("Contract Type" = xRec."Contract Type") or (("Contract Type" = '') and (xRec."No." <> "No.")) then
                    exit;
                lContract.Get("Contract Type");
                if ("Order Type" = "order type"::" ") and ("Document Type" in ["document type"::Quote, "document type"::Order]) then begin
                    Validate("Invoicing Method", lContract."Invoicing Method");
                    if not wSchedulerLinesExist and (lContract."Invoicing Method" = lContract."invoicing method"::Scheduler) then
                        lContract.InsertSalesScheduler(Rec);
                end;
                if ("Order Type" = "order type"::" ") and (lContract."Gen. Bus. Posting Group" <> '') then begin
                    Validate("Gen. Bus. Posting Group", lContract."Gen. Bus. Posting Group");
                end;
                //PROJET_FACT//

                //#5542 Code mis en commentaire par CW le 08/09/07 réactivé
                //{CW 08/09/07
                //DESCRIPTION-INSERT
                lSalesCommentLine.SetRange("Document Type", "Document Type");
                lSalesCommentLine.SetRange("No.", "No.");
                //#5821
                //lSalesCommentLine.SETRANGE(Type,lSalesCommentLine.Type::"1");
                lSalesCommentLine.SetRange("Document Line No.", -1);
                //#5821//
                if (lContract."Header Comment Code" <> '') and lSalesCommentLine.IsEmpty then begin
                    lTextCode[1] := lContract."Header Comment Code";
                    lSalesTextMgt.GetSelectedText("Document Type", "No.", 1, lTextCode, 0, Rec);
                end;
                //#5821
                //lSalesCommentLine.SETRANGE(Type,lSalesCommentLine.Type::"2");
                lSalesCommentLine.SetRange("Document Line No.", -2);
                //#5821
                if (lContract."Footer Comment Code" <> '') and lSalesCommentLine.IsEmpty then begin
                    lSalesCommentLine.DeleteAll;
                    lTextCode[1] := lContract."Footer Comment Code";
                    lSalesTextMgt.GetSelectedText("Document Type", "No.", 2, lTextCode, 0, Rec);
                end;
                //DESCRIPTION-INSERT//
                //}
                //#5542//

                //QUOTE_FOOTER
                if "Document Type" <> "document type"::Quote then
                    exit;

                lContractTypeOtherRes.SetRange("Contract Type", "Contract Type");
                if not lContractTypeOtherRes.IsEmpty then begin
                    lSalesLine.SetRange("Document Type", "Document Type");
                    lSalesLine.SetRange("Document No.", "No.");
                    lSalesLine.SetRange("Line Type", lSalesLine."line type"::Other);
                    if not lSalesLine.IsEmpty then
                        Message(TextContractType)
                    else begin
                        lSingleInstance.wSetSalesHeader(Rec);
                        wInsertOtherResLine(lContractTypeOtherRes);
                    end;
                end;
                //QUOTE_FOOTER
            end;
        }
        field(8003926; Finished; Boolean)
        {
            Caption = 'Finished';
        }
        field(8003947; "Person Responsible 2"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003947);
            Caption = 'Person Responsible 2';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#7476
                lResource.SetRange(Type, lResource.Type::Person);
                lResource.SetRange(Status, lResource.Status::Internal);
                //#9065
                if ISSERVICETIER then begin
                    if page.RunModal(8035107, lResource) = Action::LookupOK then
                        "Person Responsible 3" := lResource."No.";
                end else begin
                    //#9065//
                    if page.RunModal(0, lResource) = Action::LookupOK then
                        "Person Responsible 2" := lResource."No.";
                    //#9065
                end;
                //#9065//
                //#7476//
            end;

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003948; "Person Responsible 3"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003948);
            Caption = 'Person Responsible 3,';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#7476
                lResource.SetRange(Type, lResource.Type::Person);
                lResource.SetRange(Status, lResource.Status::Internal);
                //#9065
                if ISSERVICETIER then begin
                    if page.RunModal(8035107, lResource) = Action::LookupOK then
                        "Person Responsible 3" := lResource."No.";
                end else begin
                    //#9065//
                    if page.RunModal(0, lResource) = Action::LookupOK then
                        "Person Responsible 3" := lResource."No.";
                    //#9065
                end;
                //#9065//
                //#7476//
            end;

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003949; "Person Responsible 4"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003949);
            Caption = 'Person Responsible 4';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#7476
                lResource.SetRange(Type, lResource.Type::Person);
                lResource.SetRange(Status, lResource.Status::Internal);
                //#9065
                if ISSERVICETIER then begin
                    if page.RunModal(8035107, lResource) = Action::LookupOK then
                        "Person Responsible 3" := lResource."No.";
                end else begin
                    //#9065//
                    if page.RunModal(0, lResource) = Action::LookupOK then
                        "Person Responsible 4" := lResource."No.";
                    //#9065
                end;
                //#9065//
                //#7476//
            end;

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003950; "Person Responsible 5"; Code[20])
        {
            //CaptionClass = wGetCaptionNaviBat(8003950);
            Caption = 'Person Responsible 5';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));

            trigger OnLookup()
            var
                lResource: Record Resource;
            begin
                //#7476
                lResource.SetRange(Type, lResource.Type::Person);
                lResource.SetRange(Status, lResource.Status::Internal);
                //#9065
                if ISSERVICETIER then begin
                    if page.RunModal(8035107, lResource) = Action::LookupOK then
                        "Person Responsible 3" := lResource."No.";
                end else begin
                    //#9065//
                    if page.RunModal(0, lResource) = Action::LookupOK then
                        "Person Responsible 5" := lResource."No.";
                    //#9065
                end;
                //#9065//
                //#7476//
            end;

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003966; "Free Date 1"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003966);
            Caption = 'Free Date 1';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003967; "Free Date 2"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003967);
            Caption = 'Free Date 2';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003968; "Free Date 3"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003968);
            Caption = 'Free Date 3';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003969; "Free Date 4"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003969);
            Caption = 'Free Date 4';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003970; "Free Date 5"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003970);
            Caption = 'Free Date 5';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003971; "Free Date 6"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003971);
            Caption = 'Free Date 6';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003972; "Free Date 7"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003972);
            Caption = 'Free Date 7';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003973; "Free Date 8"; Date)
        {
            //CaptionClass = wGetCaptionNaviBat(8003973);
            Caption = 'Free Date 8';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003976; "Free Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003976);
            Caption = 'Free Value 1';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003977; "Free Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003977);
            Caption = 'Free Value 2';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003978; "Free Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003978);
            Caption = 'Free Value 3';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003979; "Free Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003979);
            Caption = 'Free Value 4';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003980; "Free Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionNaviBat(8003980);
            Caption = 'Free Value 5';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003981; "Free Boolean 1"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003981);
            Caption = 'Free Boolean 1';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003982; "Free Boolean 2"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003982);
            Caption = 'Free Boolean 2';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003983; "Free Boolean 3"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003983);
            Caption = 'Free Boolean 3';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003984; "Free Boolean 4"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003984);
            Caption = 'Free Boolean 4';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003985; "Free Boolean 5"; Boolean)
        {
            //CaptionClass = wGetCaptionNaviBat(8003985);
            Caption = 'Free Boolean 5';

            trigger OnValidate()
            begin
                wSynchroJob;
            end;
        }
        field(8003986; "Progress Degree"; Code[10])
        {
            Caption = 'Progress Degree';
            TableRelation = "Document Progress Degree" where("Document Type" = field("Document Type"));

            trigger OnValidate()
            var
                lProgress: Record "Document Progress Degree";
            begin
                wSynchroJob;
            end;
        }
        field(8003988; "Job Starting Date"; Date)
        {
            Caption = 'Date début Affaire';
        }
        field(8003989; "Job Ending Date"; Date)
        {
            Caption = 'Date fin Affaire';
        }
        field(8003990; "Transfer Job No."; Code[20])
        {
            Caption = 'Transfer Job No.';
            TableRelation = Job;
        }
        field(8003993; "No. Prepayment Request Printed"; Integer)
        {
            Caption = 'No. Prepayment Request Printed';
            Editable = false;
        }
        field(8004050; "Deadline Code"; Code[10])
        {
            Caption = 'Deadline code';
            TableRelation = "Deadline Term";

            trigger OnValidate()
            var
                lDeadlineTerm: Record "Deadline Term";
            begin
                //DEVIS
                //#5927
                if "Document Type" <> "document type"::Quote then
                    exit;
                //#5927//
                if "Deadline Code" <> '' then begin
                    TestField("Document Date");
                    lDeadlineTerm.Get("Deadline Code");
                    "Deadline Date" := CalcDate(lDeadlineTerm."Deadline formula", "Document Date");
                end else
                    "Deadline Date" := 0D;
                //DEVIS//
            end;
        }
        field(8004051; "Deadline Date"; Date)
        {
            Caption = 'Deadline';
        }
        field(8004132; "Gen. Prod Posting Group Filter"; Code[10])
        {
            Caption = 'Gen. Prod Posting Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group" where("Resource Type" = filter(<> " "));
        }
        field(8004134; "Person Quantity (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Sales Line"."Quantity (Base)" where("Document Type" = field("Document Type"),
                                                                    "Document No." = field("No."),
                                                                    "Line Type" = const(Person),
                                                                    "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                    Disable = const(false),
                                                                    Option = const(false)));
            Caption = 'Person Quantity (Base)';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
    }
    keys
    {
        /* GL2024  key(Key14; "Document Type", "Sell-to Contact Company No.")
           {
           }*/
        key(Key15; "Job No.")
        {
        }

        /* GL2024 key(Key16;"Order Type","Document Type","No.","Invoicing Method",Finished)
          {
          }*/
        key(Key17; "Rider to Order No.")
        {
        }
        key(Key18; Synchronise)
        {
        }

        key(Key19; "Sell-to Customer Name")
        {
        }

        key(Key20; "Posting Date")
        {
        }
        key(Key21; "Transfer Job No.")
        {
        }
    }

    trigger OnInsert()
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec."Apply Stamp fiscal" := false;
    end;

    trigger OnBeforeInsert()
    var
        UserMgt: Codeunit "User Setup Management";
        CduFunction: Codeunit SoroubatFucntion;
    begin
        //#5660
        IF GETFILTER("Job No.") <> '' THEN
            IF wJob.GET(GETFILTER("Job No.")) AND (wJob."Responsibility Center" <> '') THEN
                "Responsibility Center" := wJob."Responsibility Center";
        //#5660//
        //#7780
        CduFunction.fSetRespCenter("Responsibility Center");
        //#7780//
        //AGENCE
        IF (UserMgt.GetSalesFilter() = '') AND lRespCenter.READPERMISSION AND lRespCenter.FIND('-') AND
           NOT HideValidationDialog AND ("Responsibility Center" = '') THEN BEGIN
            COMMIT;
            IF page.RUNMODAL(0, lRespCenter) = ACTION::LookupOK THEN
                "Responsibility Center" := lRespCenter.Code;
        END;
        //AGENCE//
    end;

    trigger OnAfterInsert()
    var
    begin
        //MASK
        "Mask Code" := lMaskMgt.UserMask;
        //MASK//

        //+ONE+
        wSingleInstance.wSetSalesHeader(Rec);
        //+ONE+//
        // >> HJ DSFT 31-0&-2013
        IF "Order Type" = "Order Type"::"Supply Order" THEN BEGIN
            RecJob.SETRANGE("Affaire Par Defaut", TRUE);
            IF RecJob.FINDFIRST THEN BEGIN
                //  VALIDATE("Job No.",RecJob."No.");
                // VALIDATE("Sell-to Customer No.",RecJob."Bill-to Name");
            END;
        END;
        // >> HJ DSFT 31-0&-2013
        /*{
        // RB SORO 26/08/2015 BETON
        RecSalesReceivablesSetup.GET;
 IF "Document Type" = "Document Type"::Invoice THEN BEGIN
     IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
     IF RecUserSetup."Souche Facture Vente" = RecUserSetup."Souche Facture Vente"::Beton THEN BEGIN
         // "Posting No. Series" := RecSalesReceivablesSetup."Souche Facture Beton";
         "External Document No." := NoSeriesMgt.GetNextNo(RecSalesReceivablesSetup."Souche Facture Beton", TODAY, TRUE);
     END;
 END;
        // RB SORO 26/08/2015 BETON
        }*/
        // RB SORO 27/09/2017 SEPARATION CMD VENTE BETON ET CMD VENTE ENROBE
        // IF "Document Type" = "Document Type"::Order THEN BEGIN
        //     IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        //     IF RecUserSetup."Filtre Service Vente" <> RecUserSetup."Filtre Service Vente"::" " THEN BEGIN
        //         "Service Vente" := RecUserSetup."Filtre Service Vente";
        //     END;
        // END;
        // // RB SORO 27/09/2017 SEPARATION CMD VENTE BETON ET CMD VENTE ENROBE

        // // MH SORO 28-08-2020

        // IF (RecUserSetup."Prix CMDV TTC" = TRUE) AND ("Document Type" = 1) THEN Rec.VALIDATE("Prices Including VAT", TRUE);

        // // MH SORO 28-08-2020

    end;


    trigger OnModify()
    var
        lSalesHeader: Record "Sales Header";
        lSalesHeader2: Record "Sales Header";
    begin

        //PROJET_FACT
        //#4883
        //IF "Rider to Order No." = '' THEN BEGIN
        IF ("Rider to Order No." = '') AND (("Document Type" = "Document Type"::Quote) OR
          ("Document Type" = "Document Type"::Order)) THEN BEGIN
            //#4883//
            lSalesHeader.SETCURRENTKEY("Rider to Order No.");
            lSalesHeader.SETRANGE("Rider to Order No.", "No.");
            //#4491
            lSalesHeader.SETRANGE(Finished, FALSE);
            //#4491
            //#4883
            lSalesHeader.SETFILTER("Document Type", '%1|%2', "Document Type"::Quote, "Document Type"::Order);
            //#4883//
            IF NOT lSalesHeader.ISEMPTY THEN BEGIN
                lSalesHeader.FIND('-');
                REPEAT
                    //#4516
                    wUpdateRider(Rec, lSalesHeader);
                UNTIL lSalesHeader.NEXT = 0;
            END;
        END;
        //PROJET_FACT//
        //+ONE+
        wSingleInstance.wSetSalesHeader(Rec);
        //+ONE+//
        //+ABO+
        fSubscrIntegration(0);
        //+ABO+//

        // // MH SORO 28-08-2020

        // IF (RecUserSetup."Prix CMDV TTC" = TRUE) AND ("Document Type" = 1) THEN Rec.VALIDATE("Prices Including VAT", TRUE);

        // // MH SORO 28-08-2020
    end;


    trigger OnBeforeDelete()
    var
    begin
        // // >> HJ SORO 13-01-2015
        // IF UserSetup.GET(UPPERCASE(USERID)) THEN;
        // // IF NOT  UserSetup."Suppression DA" THEN ERROR(Text066);
        // "Shipping No." := '';
        // "Posting No." := '';
        // // >> HJ SORO 13-01-2015

        // IF Statut > Statut::Ouvert THEN ERROR(Text065);


        //+ABO+
        fSubscrIntegration(-1);
        //+ABO+//

    end;


    trigger OnDelete()

    var
        SalesCommentLine: Record "Sales Comment Line";
        ReservMgt: Codeunit "Reservation Management";
        CRMIntTableSubscriber: Codeunit "CRM Int. Table. Subscriber";
        lSalesLine: Record "Sales Line";

    begin
        //#6115
        lRecRef.GETTABLE(xRec);
        lBOQCustMgt.gOndelete(lRecRef, TRUE);
        //#6115//
        //PERF
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        //PERF//
        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.SetRange(Type, SalesLine.Type::"Charge (Item)");

        if SalesLine.FindSet() then begin
            ReservMgt.DeleteDocumentReservation(DATABASE::"Sales Line", "Document Type".AsInteger(), "No.", GetHideValidationDialog());
            repeat
                SalesLine.SuspendStatusCheck(true);
                SalesLine.Delete(true);
            until SalesLine.Next() = 0;
        end;
        SalesLine.SetRange(Type);
        //PERF
        SalesLine.SETRANGE("Structure Line No.", 0);
        SalesLine.SETRANGE("Line Type", SalesLine."Line Type"::Totaling);
        if SalesLine.FindSet() then begin
            ReservMgt.DeleteDocumentReservation(DATABASE::"Sales Line", "Document Type".AsInteger(), "No.", GetHideValidationDialog());
            repeat
                SalesLine.SuspendStatusCheck(true);
                SalesLine.Delete(true);
            until SalesLine.Next() = 0;
        end;
        SalesLine.SETRANGE("Line Type");
        //PERF//
        if SalesLine.FindSet() then begin
            ReservMgt.DeleteDocumentReservation(DATABASE::"Sales Line", "Document Type".AsInteger(), "No.", GetHideValidationDialog());
            repeat
                SalesLine.SuspendStatusCheck(true);
                SalesLine.Delete(true);
            until SalesLine.Next() = 0;
        end;

        SalesCommentLine.SetRange("Document Type", "Document Type");
        SalesCommentLine.SetRange("No.", "No.");
        SalesCommentLine.DeleteAll();
        //#7639
        //#6115
        lRecRef.GETTABLE(xRec);
        lBOQCustMgt.gOndelete(lRecRef, TRUE);
        //#6115//
        //#7639//


        CRMIntTableSubscriber.MarkArchivedSalesOrder(Rec);

        //CONTRIBUTOR
        IF ("Document Type" = "Document Type"::Quote) AND ("Order Type" = "Order Type"::" ") THEN BEGIN
            wSalesContributor.RESET;
            wSalesContributor.SETRANGE("Document Type", "Document Type");
            wSalesContributor.SETRANGE("Document No.", "No.");
            wSalesContributor.DELETEALL(TRUE);
        END;
        //CONTRIBUTOR//

        //PROJET_FACT
        IF ("Document Type" IN ["Document Type"::Quote, "Document Type"::Order]) AND ("Order Type" = "Order Type"::" ") THEN BEGIN
            lInvScheduler.SETRANGE("Sales Header Doc. Type", "Document Type");
            lInvScheduler.SETRANGE("Sales Header Doc. No.", "No.");
            lInvScheduler.DELETEALL;
        END;
        //PROJET_FACT//

        //PROJET_FG
        lSalesOverhead.SETRANGE("Document Type", "Document Type");
        lSalesOverhead.SETRANGE("Document No.", "No.");
        lSalesOverhead.DELETEALL;

        lJobBudgetEntry.SETCURRENTKEY("Document Type", "Document No.");
        lJobBudgetEntry.SETRANGE("Document Type", "Document Type");
        lJobBudgetEntry.SETRANGE("Document No.", "No.");
        IF NOT lJobBudgetEntry.ISEMPTY THEN
            lJobBudgetEntry.DELETEALL(TRUE);
        //PROJET_FG//

        //CDE_CESSION
        IF ("Order Type" = "Order Type"::Transfer) AND NOT wDeleteInternalOrderLink THEN BEGIN
            lTransferOrderLink.SETCURRENTKEY("Transfer Document Type", "Transfer Document No.");
            lTransferOrderLink.SETRANGE("Transfer Document Type", "Document Type");
            lTransferOrderLink.SETRANGE("Transfer Document No.", "No.");
            IF NOT lTransferOrderLink.ISEMPTY THEN BEGIN
                lSalesLine.SuspendStatusCheck(TRUE);
                lTransferOrderLink.FIND('-');
                REPEAT
                    lSalesLine.GET(lTransferOrderLink."Document Type", lTransferOrderLink."Document No.", lTransferOrderLink."Line No.");
                    lSalesLine."Supply Order No." := '';
                    lSalesLine."Supply Order Line No." := 0;
                    lSalesLine.VALIDATE(Disable, FALSE);
                    lSalesLine.MODIFY;
                UNTIL lTransferOrderLink.NEXT = 0;
                lTransferOrderLink.FIND('-');
                REPEAT
                    IF lTransferOrderLink."Structure Line No." = 0 THEN BEGIN
                        lSalesLine.GET(lTransferOrderLink."Document Type", lTransferOrderLink."Document No.", lTransferOrderLink."Line No.");
                        IF lSalesLine."Line Type" = lSalesLine."Line Type"::Structure THEN BEGIN
                            lStructureMgt.SumStructureLines(lSalesLine);
                            lSalesLine.MODIFY;
                        END;
                    END;
                UNTIL lTransferOrderLink.NEXT = 0;
                lSalesLine.SuspendStatusCheck(FALSE);
                lTransferOrderLink.FIND('-');
                REPEAT
                    IF lOldDocumentNo <> lTransferOrderLink."Document No." THEN BEGIN
                        lSalesHeader.SETRANGE("Document Type", lTransferOrderLink."Document Type");
                        lSalesHeader.SETRANGE("No.", lTransferOrderLink."Document No.");
                        //DYS REPORT addon non migrer
                        // REPORT.RUN(REPORT::"Restore doc. Totaling", FALSE, FALSE, lSalesHeader);
                        //mise … jour du budget de la commande initiale
                        //DYS
                        // CLEAR(lSalesToJobBudgetEntry);
                        // lSalesToJobBudgetEntry.InitTransfer(TRUE);
                        // lSalesToJobBudgetEntry.InitReport(lSalesHeader);
                        // lSalesToJobBudgetEntry.SETTABLEVIEW(lSalesHeader);
                        // lSalesToJobBudgetEntry.USEREQUESTFORM := FALSE;
                        // lSalesToJobBudgetEntry.RUNMODAL;
                        //mise … jour du budget de la commande initiale//
                        lOldDocumentNo := lTransferOrderLink."Document No.";
                    END;
                UNTIL lTransferOrderLink.NEXT = 0;

                lTransferOrderLink.DELETEALL;
            END;
            //CDE_CESSION
        END;
    end;

    procedure UpdateShipToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Customer: Record Customer;
        Cont: Record Contact;
        //GL2024   CustTemplate: Record 5105;
        ContComp: Record Contact;
    begin
        if Cont.Get(ContactNo) then begin
            "Ship-to Contact No." := Cont."No.";
            //#7890
            "Ship-to Contact" := Cont.Name;
            //#7890//
        end else begin
            "Ship-to Contact" := '';
            exit;
        end;
        //#7497
        //IF "Document Type" = "Document Type"::Quote THEN BEGIN
        if ("Document Type" = "document type"::Quote) or ("Order Type" = "order type"::"Supply Order") then begin
            //#7497//
            "Ship-to Contact" := Cont.Name;
            //#6560
            if ("Job No." = '') then
                "Ship-to Name" := Cont."Company Name";
            //#6560//
            //#7497
            if "Order Type" = "order type"::"Supply Order" then
                "Ship-to Name" := Cont.Name;
            //#7497//
            "Ship-to Name 2" := Cont."Name 2";
            "Ship-to Address" := Cont.Address;
            "Ship-to Address 2" := Cont."Address 2";
            "Ship-to City" := Cont.City;
            "Ship-to Post Code" := Cont."Post Code";
            "Ship-to County" := Cont.County;
            "Ship-to Phone No." := Cont."Phone No.";
            "Ship-to Fax No." := Cont."Fax No.";

            Validate("Ship-to Country/Region Code", Cont."Country/Region Code");
        end;
    end;

    procedure wCalcNextInvoiceDate()
    begin
        //+ABO+
        if "Document Date" = 0D then
            "Next Invoice Date" := "Document Date"
        else
            "Next Invoice Date" := CalcDate("Next Invoice Calculation", "Document Date");
        //+ABO+//
    end;

    procedure fSubscrIntegration(pFieldNo: Integer)
    begin
        //+ABO+
        if (gLicensePermission."Object Type" <> gLicensePermission."object type"::Codeunit) or
           (gLicensePermission."Object Number" <> Codeunit::"Sales Subscription Integr.") then
            gLicensePermission.Get(gLicensePermission."object type"::Codeunit, Codeunit::"Sales Subscription Integr.");
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

    procedure wCreateNewLine()
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "No.");
        if not lSalesLine.Find('-') then begin
            lSalesLine."Document Type" := "Document Type";
            lSalesLine."Document No." := "No.";
            lSalesLine."Line No." := 10000;
            lSalesLine.Level := 1;
            lSalesLine."Presentation Code" := '  1';
            lSalesLine.Insert;
        end;
    end;

    procedure wPostingDescription(): Text[100]
    var
        lNaviBatSetup: Record NavibatSetup;
    begin
        //POSTING_DESC
        //IF "Posting Description" = '' THEN BEGIN
        lNaviBatSetup.GET2;
        //  lNaviBatSetup.TESTFIELD("Sales Document Description");
        exit(lNaviBatSetup."Sales Document Description");
        //END;
        //POSTING_DESC//
    end;

    procedure wShowPostingDescription(pFormule: Text[100]): Text[100]
    var
        lRecordRef: RecordRef;
        lBasic: Codeunit Basic;
        lGenJnlLine: Record "Gen. Journal Line";
        lCustomer: Record Customer;
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

        //#7529
        if StrPos(lFormula, '%' + Format(Database::"Sales Header") + '.') > 0 then begin
            lRecordRef.GetTable(Rec);
            lBasic.SubstituteValues(lFormula, lRecordRef, '%' + Format(Database::"Sales Header") + '.', GlobalLanguage);
        end;
        if StrPos(lFormula, '%' + Format(Database::Customer) + '.') > 0 then begin
            if lCustomer.Get("Sell-to Customer No.") then;
            lRecordRef.GetTable(lCustomer);
            lBasic.SubstituteValues(lFormula, lRecordRef, '%' + Format(Database::Customer) + '.', GlobalLanguage);
        end;
        if StrPos(lFormula, '%' + Format(Database::Job) + '.') > 0 then begin
            if lJob.Get("Job No.") then;
            lRecordRef.GetTable(lJob);
            lBasic.SubstituteValues(lFormula, lRecordRef, '%' + Format(Database::Job) + '.', GlobalLanguage);
        end;
        //#7529

        lBasic.SubstituteValues(lFormula, lRecordRef, '%', GlobalLanguage);
        //#RTC --2009
        if (StrLen(lFormula) > MaxStrLen(pFormule)) then
            pFormule := CopyStr(lFormula, 1, MaxStrLen(pFormule))
        else
            pFormule := lFormula;
        //#RTC -- 2009//

        exit(pFormule);
        //POSTING_DESC//
    end;

    procedure wGetCaptionNaviBat(pFieldNumber: Integer): Text[250]
    var
        lNaviBatSetup: Record NavibatSetup;
        lReturnText: Text[250];
    begin
        with lNaviBatSetup do begin
            GET2;
            case pFieldNumber of
                8003912:
                    if "Person Responsible Name 1" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible");
                8003947:
                    if "Person Responsible Name 2" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 2");
                8003948:
                    if "Person Responsible Name 3" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 3");
                8003949:
                    if "Person Responsible Name 4" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 4");
                8003950:
                    if "Person Responsible Name 5" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 5");
                /*
                //#5946
                     8003956:
                      IF "Free Field Name 1" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 1"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 1");
                     8003957:
                      IF "Free Field Name 2" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 2"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 2");
                     8003958:
                      IF "Free Field Name 3" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 3"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 3");
                     8003959:
                      IF "Free Field Name 4" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 4"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 4");
                     8003960:
                      IF "Free Field Name 5" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 5"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 5");
                     8003961:
                      IF "Free Field Name 6" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 6"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 6");
                     8003962:
                      IF "Free Field Name 7" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 7"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 7");
                     8003963:
                      IF "Free Field Name 8" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 8"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 8");
                     8003964:
                      IF "Free Field Name 9" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 9"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 9");
                     8003965:
                      IF "Free Field Name 10" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 10"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 10");
                //#5946//
                */
                8003966:
                    if "Free Date Name 1" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 1");
                8003967:
                    if "Free Date Name 2" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 2");
                8003968:
                    if "Free Date Name 3" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 3");
                8003969:
                    if "Free Date Name 4" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 4");
                8003970:
                    if "Free Date Name 5" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 5");
                8003971:
                    if "Free Date Name 6" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 6"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 6");
                8003972:
                    if "Free Date Name 7" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 7"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 7");
                8003973:
                    if "Free Date Name 8" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 8"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 8");
                //#5946
                //     8003974:
                //      IF "Free Date Name 9" <> '' THEN
                //        lReturnText := '1,5,,'+ "Free Date Name 9"
                //      ELSE
                //        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Date 9");
                //     8003975:
                //      IF "Free Date Name 10" <> '' THEN
                //        lReturnText := '1,5,,'+ "Free Date Name 10"
                //      ELSE
                //        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Date 10");
                //#5946
                8003976:
                    if "Free Value Name 1" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 1");
                8003977:
                    if "Free Value Name 2" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 2");
                8003978:
                    if "Free Value Name 3" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 3");
                8003979:
                    if "Free Value Name 4" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 4");
                8003980:
                    if "Free Value Name 5" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 5");
                8003981:
                    if "Free Boolean Name 1" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 1");
                8003982:
                    if "Free Boolean Name 2" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 2");
                8003983:
                    if "Free Boolean Name 3" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 3");
                8003984:
                    if "Free Boolean Name 4" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 4");
                8003985:
                    if "Free Boolean Name 5" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 5");
            end;
            exit(lReturnText);
        end;

    end;

    procedure wSynchroJob()
    begin
        //#3966
        /*
        IF "Job No." <> '' THEN BEGIN
          wNaviBatSetup.GET;
          IF wStatisticSetup.FIND('-') THEN;
          CASE CurrFieldNo OF
        //3069    FIELDNO("Salesperson Code") : wSynchro(CurrFieldNo,FIELDCAPTION("Salesperson Code"));
            FIELDNO("Criteria 1") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 1");
            FIELDNO("Criteria 2") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 2");
            FIELDNO("Criteria 3") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 3");
            FIELDNO("Criteria 4") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 4");
            FIELDNO("Criteria 5") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 5");
            FIELDNO("Criteria 6") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 6");
            FIELDNO("Criteria 7") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 7");
            FIELDNO("Criteria 8") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 8");
            FIELDNO("Criteria 9") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 9");
            FIELDNO("Criteria 10") : wSynchro(CurrFieldNo,wStatisticSetup."Job criteria name 10");
            FIELDNO("Person Responsible")   :
                IF wNaviBatSetup."Person Resp. 1 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Person Responsible Name 1");
            FIELDNO("Person Responsible 2") :
                IF wNaviBatSetup."Person Resp. 2 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Person Responsible Name 2");
            FIELDNO("Person Responsible 3") :
                IF wNaviBatSetup."Person Resp. 3 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Person Responsible Name 3");
            FIELDNO("Person Responsible 4") :
                IF wNaviBatSetup."Person Resp. 4 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Person Responsible Name 4");
            FIELDNO("Person Responsible 5") :
                IF wNaviBatSetup."Person Resp. 5 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Person Responsible Name 5");
            FIELDNO("Free Field 1") :
                IF wNaviBatSetup."Free Field 1 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 1");
            FIELDNO("Free Field 2") :
                IF wNaviBatSetup."Free Field 2 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 2");
            FIELDNO("Free Field 3") :
                IF wNaviBatSetup."Free Field 3 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 3");
            FIELDNO("Free Field 4") :
                IF wNaviBatSetup."Free Field 4 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 4");
            FIELDNO("Free Field 5") :
                IF wNaviBatSetup."Free Field 5 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 5");
            FIELDNO("Free Field 6") :
                IF wNaviBatSetup."Free Field 6 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 6");
            FIELDNO("Free Field 7") :
                IF wNaviBatSetup."Free Field 7 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 7");
            FIELDNO("Free Field 8") :
                IF wNaviBatSetup."Free Field 8 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 8");
            FIELDNO("Free Field 9") :
                IF wNaviBatSetup."Free Field 9 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 9");
            FIELDNO("Free Field 10") :
                IF wNaviBatSetup."Free Field 10 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Field Name 10");
            FIELDNO("Free Date 1") :
                IF wNaviBatSetup."Free Date 1 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 1");
            FIELDNO("Free Date 2") :
                IF wNaviBatSetup."Free Date 2 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 2");
            FIELDNO("Free Date 3") :
                IF wNaviBatSetup."Free Date 3 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 3");
            FIELDNO("Free Date 4") :
                IF wNaviBatSetup."Free Date 4 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 4");
            FIELDNO("Free Date 5") :
                IF wNaviBatSetup."Free Date 5 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 5");
            FIELDNO("Free Date 6") :
                IF wNaviBatSetup."Free Date 6 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 6");
            FIELDNO("Free Date 7") :
                IF wNaviBatSetup."Free Date 7 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 7");
            FIELDNO("Free Date 8") :
                IF wNaviBatSetup."Free Date 8 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 8");
            FIELDNO("Free Date 9") :
                IF wNaviBatSetup."Free Date 9 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 9");
            FIELDNO("Free Date 10") :
                IF wNaviBatSetup."Free Date 10 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Date Name 10");
            FIELDNO("Free Value 1") :
                IF wNaviBatSetup."Free Value 1 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Value Name 1");
            FIELDNO("Free Value 2") :
                IF wNaviBatSetup."Free Value 2 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Value Name 2");
            FIELDNO("Free Value 3") :
                IF wNaviBatSetup."Free Value 3 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Value Name 3");
            FIELDNO("Free Value 4") :
                IF wNaviBatSetup."Free Value 4 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Value Name 4");
            FIELDNO("Free Value 5") :
                IF wNaviBatSetup."Free Value 5 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Value Name 5");
            FIELDNO("Free Boolean 1") :
                IF wNaviBatSetup."Free Boolean 1 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Boolean Name 1");
            FIELDNO("Free Boolean 2") :
                IF wNaviBatSetup."Free Boolean 2 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Boolean Name 2");
            FIELDNO("Free Boolean 3") :
                IF wNaviBatSetup."Free Boolean 3 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Boolean Name 3");
            FIELDNO("Free Boolean 4") :
                IF wNaviBatSetup."Free Boolean 4 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Boolean Name 4");
            FIELDNO("Free Boolean 5") :
                IF wNaviBatSetup."Free Boolean 5 Option" = 0 THEN wSynchro(CurrFieldNo,wNaviBatSetup."Free Boolean Name 5");
            ELSE;
          END;
        END;
        //#3966
        */

    end;

    procedure wSynchro(pCurrFieldNo: Integer; pCaption: Text[50])
    var
        lJob: Record Job;
        lSalesDoc: Record "Sales Header";
        lRecRefSales: RecordRef;
        lFieldRefSales: FieldRef;
        lFieldRefSalesNo: FieldRef;
        lRecRefJob: RecordRef;
        lFieldRefJob: FieldRef;
        lFieldRefJobNo: FieldRef;
        lCurrFieldNoJob: Integer;
        lValue: Text[50];
        lOK: Boolean;
    begin
        if lJob.Get("Job No.") then begin
            case pCurrFieldNo of
                8003912:
                    lCurrFieldNoJob := 20;
                FieldNo("Salesperson Code"):
                    lCurrFieldNoJob := 8003917;
                else
                    lCurrFieldNoJob := pCurrFieldNo;
            end;

            lRecRefSales.GetTable(Rec);
            lFieldRefSales := lRecRefSales.Field(pCurrFieldNo);
            lRecRefJob.GetTable(lJob);
            lFieldRefJob := lRecRefJob.Field(lCurrFieldNoJob);
            lFieldRefJobNo := lRecRefJob.Field(1);
            Evaluate(lValue, Format(lFieldRefJob.Value));
            if lValue = '' then
                exit;
            if (lFieldRefSales.Value <> lFieldRefJob.Value) and (lValue <> '') then
                if not Confirm(
                  TextSynchro, true, pCaption,
                  lFieldRefJob.Value, lFieldRefSales.Value, lFieldRefJobNo.Value, '')
                then
                    exit;

            if (lFieldRefSales.Value <> lFieldRefJob.Value) then begin
                lFieldRefJob.Value(lFieldRefSales.Value);
                lFieldRefJob.Validate;
                lRecRefJob := lFieldRefJob.Record;
                lRecRefJob.Modify;

                lOK := false;
                lSalesDoc.SetCurrentkey("Job No.");
                lSalesDoc.SetRange("Job No.", lJob."No.");
                if lSalesDoc.Find('-') then
                    repeat
                        if not ((lSalesDoc."Document Type" = "Document Type") and (lSalesDoc."No." = "No.")) then begin
                            lRecRefSales.GetTable(lSalesDoc);
                            lFieldRefSales := lRecRefSales.Field(pCurrFieldNo);
                            lFieldRefSalesNo := lRecRefSales.Field(3);
                            Evaluate(lValue, Format(lFieldRefSales.Value));
                            if (lFieldRefSales.Value <> lFieldRefJob.Value) and (lValue <> '') and not lOK then begin
                                if not Confirm(
                                   TextSynchro2, true, pCaption,
                                   lFieldRefSales.Value, lFieldRefJob.Value,
                                   lJob."No.")
                                then
                                    exit
                                else
                                    lOK := true;
                            end;
                            lFieldRefSales.Value(lFieldRefJob.Value);
                            lRecRefSales := lFieldRefSales.Record;
                            lRecRefSales.Modify;
                        end;
                    until lSalesDoc.Next = 0;
            end;
        end;
    end;

    procedure wUpdateDocFromJob()
    var
        lJob: Record Job;
    begin
        if "Job No." <> '' then
            if lJob.Get("Job No.") then begin
                //#5660 Previous code deleted CW
                wNaviBatSetup.GET;
                if wStatisticSetup.Find('-') then;
                //3069  lJob.wSynchro(lJob.FIELDNO("Salesperson Code"),lJob.FIELDCAPTION("Salesperson Code"));
                "Criteria 1" := lJob."Criteria 1";
                "Criteria 2" := lJob."Criteria 2";
                "Criteria 3" := lJob."Criteria 3";
                "Criteria 4" := lJob."Criteria 4";
                "Criteria 5" := lJob."Criteria 5";
                "Criteria 6" := lJob."Criteria 6";
                "Criteria 7" := lJob."Criteria 7";
                "Criteria 8" := lJob."Criteria 8";
                "Criteria 9" := lJob."Criteria 9";
                "Criteria 10" := lJob."Criteria 10";
                if wNaviBatSetup."Person Resp. 1 Option" = 0 then "Person Responsible" := lJob."Person Responsible";
                if wNaviBatSetup."Person Resp. 2 Option" = 0 then "Person Responsible 2" := lJob."Person Responsible 2";
                if wNaviBatSetup."Person Resp. 3 Option" = 0 then "Person Responsible 3" := lJob."Person Responsible 3";
                if wNaviBatSetup."Person Resp. 4 Option" = 0 then "Person Responsible 4" := lJob."Person Responsible 4";
                if wNaviBatSetup."Person Resp. 5 Option" = 0 then "Person Responsible 5" := lJob."Person Responsible 5";
                //#5946
                /*
                  IF wNaviBatSetup."Free Field 1 Option" = 0 THEN "Free Field 1" := lJob."Free Field 1";
                  IF wNaviBatSetup."Free Field 2 Option" = 0 THEN "Free Field 2" := lJob."Free Field 2";
                  IF wNaviBatSetup."Free Field 3 Option" = 0 THEN "Free Field 3" := lJob."Free Field 3";
                  IF wNaviBatSetup."Free Field 4 Option" = 0 THEN "Free Field 4" := lJob."Free Field 4";
                  IF wNaviBatSetup."Free Field 5 Option" = 0 THEN "Free Field 5" := lJob."Free Field 5";
                  IF wNaviBatSetup."Free Field 6 Option" = 0 THEN "Free Field 6" := lJob."Free Field 6";
                  IF wNaviBatSetup."Free Field 7 Option" = 0 THEN "Free Field 7" := lJob."Free Field 7";
                  IF wNaviBatSetup."Free Field 8 Option" = 0 THEN "Free Field 8" := lJob."Free Field 8";
                  IF wNaviBatSetup."Free Field 9 Option" = 0 THEN "Free Field 9" := lJob."Free Field 9";
                  IF wNaviBatSetup."Free Field 10 Option" = 0 THEN "Free Field 10" := lJob."Free Field 10";
                */
                //#5946//
                if wNaviBatSetup."Free Date 1 Option" = 0 then "Free Date 1" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 2 Option" = 0 then "Free Date 2" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 3 Option" = 0 then "Free Date 3" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 4 Option" = 0 then "Free Date 4" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 5 Option" = 0 then "Free Date 5" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 6 Option" = 0 then "Free Date 6" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 7 Option" = 0 then "Free Date 7" := lJob."Free Date 1";
                if wNaviBatSetup."Free Date 8 Option" = 0 then "Free Date 8" := lJob."Free Date 1";
                //#5946
                //  IF wNaviBatSetup."Free Date 9 Option" = 0 THEN "Free Date 9" := lJob."Free Date 1";
                //  IF wNaviBatSetup."Free Date 10 Option" = 0 THEN "Free Date 10" := lJob."Free Date 10";
                //#5946//
                if wNaviBatSetup."Free Value 1 Option" = 0 then "Free Value 1" := lJob."Free Value 1";
                if wNaviBatSetup."Free Value 2 Option" = 0 then "Free Value 2" := lJob."Free Value 2";
                if wNaviBatSetup."Free Value 3 Option" = 0 then "Free Value 3" := lJob."Free Value 3";
                if wNaviBatSetup."Free Value 4 Option" = 0 then "Free Value 4" := lJob."Free Value 4";
                if wNaviBatSetup."Free Value 5 Option" = 0 then "Free Value 5" := lJob."Free Value 5";
                if wNaviBatSetup."Free Boolean 1 Option" = 0 then "Free Boolean 1" := "Free Boolean 1";
                if wNaviBatSetup."Free Boolean 2 Option" = 0 then "Free Boolean 2" := "Free Boolean 2";
                if wNaviBatSetup."Free Boolean 3 Option" = 0 then "Free Boolean 3" := "Free Boolean 3";
                if wNaviBatSetup."Free Boolean 4 Option" = 0 then "Free Boolean 4" := "Free Boolean 4";
                if wNaviBatSetup."Free Boolean 5 Option" = 0 then "Free Boolean 5" := "Free Boolean 5";
                "Job Starting Date" := lJob."Starting Date";
                "Job Ending Date" := lJob."Ending Date";
            end;
    end;

    procedure wUpdateContactCompanyNo()
    var
        lContact: Record Contact;
    begin
        //CRM
        if "Sell-to Contact No." <> '' then begin
            lContact.Get("Sell-to Contact No.");
            if lContact."Company No." <> '' then
                "Sell-to Contact Company No." := lContact."Company No."
            else
                "Sell-to Contact Company No." := "Sell-to Contact No.";
        end;
        //CRM//
    end;

    procedure wShowDocumentInteraction(pRec: Record "Sales Header")
    var
        lInteractionLogForm: page "Interaction Log Entries";
        lInteractionLogEntry: Record "Interaction Log Entry";
    begin
        //CRM
        lInteractionLogEntry.SetCurrentkey("Sales Document Type", "Sales Document No.");
        lInteractionLogEntry.SetRange("Sales Document Type", pRec."Document Type");
        lInteractionLogEntry.SetRange("Sales Document No.", pRec."No.");
        Clear(lInteractionLogForm);
        lInteractionLogForm.fSetFromSalesDoc(true);
        lInteractionLogForm.SetTableview(lInteractionLogEntry);
        lInteractionLogForm.Run;
        //CRM//
    end;

    local procedure lGetCaptionsStatsExplorer(pFieldID: Integer): Text[250]
    var
        lStatisticAggregate: Record "Statistic aggregate";
    begin
        if lStatisticAggregate.ReadPermission then
            exit(lStatisticAggregate.GetCaptionsStatsExplorer(pFieldID))
        else
            exit('');
    end;

    procedure wSchedulerLinesExist(): Boolean
    var
        lScheduler: Record "Invoice Scheduler";
    begin
        //PROJET_FACT
        if "Invoicing Method" <> "invoicing method"::Scheduler then
            exit(false);
        lScheduler.Reset;
        lScheduler.SetRange("Sales Header Doc. Type", "Document Type");
        lScheduler.SetRange("Sales Header Doc. No.", "No.");
        exit(not lScheduler.IsEmpty);
    end;

    procedure wUpdateSchedulerLines(pChangedFieldName: Text[100]; pAskQuestion: Boolean)
    var
        lScheduler: Record "Invoice Scheduler";
        lQuestion: Text[250];
        lUpdateLines: Boolean;
    begin
        //PROJET_FACT
        if wSchedulerLinesExist and pAskQuestion then begin
            lQuestion := StrSubstNo(
              Text031 +
              Text032, pChangedFieldName);
            if not Dialog.Confirm(lQuestion, true) then
                exit;
        end;

        if wSchedulerLinesExist then begin
            lScheduler.LockTable;
            lScheduler.Reset;
            lScheduler.SetRange("Sales Header Doc. Type", "Document Type");
            lScheduler.SetRange("Sales Header Doc. No.", "No.");
            if lScheduler.FindSet(true) then
                repeat
                    case pChangedFieldName of
                        FieldCaption("Job No."):
                            lScheduler.Validate("Job No.", "Job No.");
                    end;
                    lScheduler.Modify(true);
                until lScheduler.Next = 0;
        end;
    end;

    procedure wCountActiveLine(): Integer
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option);
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetFilter("Line Type", '<>%1&<>%2', lSalesLine."line type"::" ", lSalesLine."line type"::Other);
        if lSalesLine.IsEmpty then
            exit(0);
        exit(lSalesLine.Count);
    end;

    procedure wSetDeleteInternalOrderLink(pDeleteInternalOrderLink: Boolean)
    begin
        wDeleteInternalOrderLink := pDeleteInternalOrderLink
    end;

    procedure wInsertOtherResLine(pContractTypeOtherRes: Record "Contract Type - Other Res.")
    var
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lLineNo: Integer;
    begin
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "No.");
        lSalesLine.SetRange("Line Type", lSalesLine."line type"::Other);
        if lSalesLine.IsEmpty then begin
            lSalesLine.SetRange("Line Type");
            if lSalesLine.FindLast then
                lLineNo := lSalesLine."Line No." + 10000
            else
                lLineNo := 10000;

            //#6817
            pContractTypeOtherRes.SetRange("Contract Type", "Contract Type");
            //#6817//
            if pContractTypeOtherRes.FindSet then
                repeat
                    lSalesLine."Document Type" := "Document Type";
                    lSalesLine."Document No." := "No.";
                    lSalesLine."Line Type" := lSalesLine."line type"::Other;
                    lSalesLine."Line No." := lLineNo;
                    //#5295
                    //    lSalesLine."Presentation Code" := '';
                    lSalesLine."Presentation Code" := '999';
                    //#5295//
                    lSalesLine.Level := 1;
                    lSalesLine.Type := lSalesLine2.Type::Resource;
                    lSalesLine.Validate("No.", pContractTypeOtherRes."No.");
                    lSalesLine."Value Option" := pContractTypeOtherRes."Value Option";
                    lSalesLine."Rate Amount" := pContractTypeOtherRes."Rate Amount";
                    lSalesLine."Assignment Method" := pContractTypeOtherRes."Assignment Method";
                    lSalesLine."Assignment Basis" := pContractTypeOtherRes."Assignment Basis";
                    //#6817
                    lSalesLine."Structure Line No." := 0;
                    //#6817//
                    lSalesLine.Insert;
                    lLineNo += 10000;
                until pContractTypeOtherRes.Next = 0;
        end;
    end;

    procedure wNotOnlyOtherLine(): Boolean
    begin
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.SetRange("Document No.", "No.");
        //#4331
        SalesLine.SetFilter("Line Type", '<>%1', SalesLine."line type"::Other);
        //#4331//
        exit(SalesLine.Find('-'));
    end;

    procedure wUpdateRider(pMainOrder: Record "Sales Header"; var pSalesHeader: Record "Sales Header")
    var
    // lReleaseSalesDoc: Codeunit 414;
    begin
        //#6631
        // Avant d'effectuer le traitement, il faut s'assurer des points suivants
        // 1) Le même numero de donneur d'ordre
        // 2) Le même numero de client facturé
        // 3) Le même code devise
        if (pSalesHeader."Sell-to Customer No." <> '') then
            pMainOrder.TestField("Sell-to Customer No.", pSalesHeader."Sell-to Customer No.");
        if (pSalesHeader."Bill-to Customer No." <> '') then
            pMainOrder.TestField("Bill-to Customer No.", pSalesHeader."Bill-to Customer No.");
        if (pSalesHeader."Currency Code" <> '') then
            pMainOrder.TestField("Currency Code", pSalesHeader."Currency Code");

        if pSalesHeader."Bill-to Customer No." <> pMainOrder."Bill-to Customer No." then
            pSalesHeader.Validate("Bill-to Customer No.", pMainOrder."Bill-to Customer No.");
        //#6631//
        if pSalesHeader."Sell-to Customer No." <> pMainOrder."Sell-to Customer No." then
            pSalesHeader.Validate("Sell-to Customer No.", pMainOrder."Sell-to Customer No.");
        if pSalesHeader."Ship-to Code" <> pMainOrder."Ship-to Code" then
            pSalesHeader.Validate("Ship-to Code", pMainOrder."Ship-to Code");
        if pSalesHeader."Ship-to Name" <> pMainOrder."Ship-to Name" then
            pSalesHeader.Validate("Ship-to Name", pMainOrder."Ship-to Name");
        if pSalesHeader."Project Manager" <> pMainOrder."Project Manager" then
            pSalesHeader.Validate("Project Manager", pMainOrder."Project Manager");
        if pSalesHeader."Job No." <> pMainOrder."Job No." then
            pSalesHeader.Validate("Job No.", pMainOrder."Job No.");
        if pSalesHeader."Job Starting Date" <> pMainOrder."Job Starting Date" then
            pSalesHeader.Validate("Job Starting Date", pMainOrder."Job Starting Date");
        if pSalesHeader."Job Ending Date" <> pMainOrder."Job Ending Date" then
            pSalesHeader.Validate("Job Ending Date", pMainOrder."Job Ending Date");
        if pSalesHeader."Contract Type" <> pMainOrder."Contract Type" then
            pSalesHeader.Validate("Contract Type", pMainOrder."Contract Type");
        //IF pSalesHeader."Bill-to Customer No." <> pMainOrder."Bill-to Customer No." THEN
        //  pSalesHeader.VALIDATE("Bill-to Customer No.",pMainOrder."Bill-to Customer No.");
        pSalesHeader."Posting Description" := pMainOrder."Posting Description";
        if pSalesHeader."Payment Terms Code" <> pMainOrder."Payment Terms Code" then
            pSalesHeader.Validate("Payment Terms Code", pMainOrder."Payment Terms Code");
        if pSalesHeader."Currency Code" <> pMainOrder."Currency Code" then
            pSalesHeader.Validate("Currency Code", pMainOrder."Currency Code");
        //IF pSalesHeader."Part Payment" <> pMainOrder."Part Payment" THEN
        //  pSalesHeader.VALIDATE("Part Payment",pMainOrder."Part Payment");
        if pSalesHeader."Gen. Bus. Posting Group" <> pMainOrder."Gen. Bus. Posting Group" then
            pSalesHeader.Validate("Gen. Bus. Posting Group", pMainOrder."Gen. Bus. Posting Group");
        if pSalesHeader."Responsibility Center" <> pMainOrder."Responsibility Center" then
            pSalesHeader.Validate("Responsibility Center", pMainOrder."Responsibility Center");
        //IF pSalesHeader."Revision % Submitted" <> pMainOrder."Revision % Submitted" THEN
        //  pSalesHeader.VALIDATE("Revision % Submitted",pMainOrder."Revision % Submitted");
        if pSalesHeader."Review Formula Code" <> pMainOrder."Review Formula Code" then
            pSalesHeader.Validate("Review Formula Code", pMainOrder."Review Formula Code");
        if pSalesHeader."Review Base Date" <> pMainOrder."Review Base Date" then
            pSalesHeader.Validate("Review Base Date", pMainOrder."Review Base Date");
        //IF pSalesHeader.Application <> pMainOrder.Application THEN
        //  pSalesHeader.VALIDATE(Application,pMainOrder.Application);
        if pSalesHeader."Person Responsible" <> pMainOrder."Person Responsible" then
            pSalesHeader.Validate("Person Responsible", pMainOrder."Person Responsible");
        if pSalesHeader."Person Responsible 2" <> pMainOrder."Person Responsible 2" then
            pSalesHeader.Validate("Person Responsible 2", pMainOrder."Person Responsible 2");
        if pSalesHeader."Person Responsible 3" <> pMainOrder."Person Responsible 3" then
            pSalesHeader.Validate("Person Responsible 3", pMainOrder."Person Responsible 3");
        if pSalesHeader."Person Responsible 4" <> pMainOrder."Person Responsible 4" then
            pSalesHeader.Validate("Person Responsible 4", pMainOrder."Person Responsible 4");
        if pSalesHeader."Person Responsible 5" <> pMainOrder."Person Responsible 5" then
            pSalesHeader.Validate("Person Responsible 5", pMainOrder."Person Responsible 5");
        //#4516//
        //#6313
        //On ne va mettre à jour ce champ ssi le champ src n'est pas vide
        //Et que la valeur de ce champ est différent pour chacun des documents
        if ((pMainOrder."Ship-to Contact" <> '') and (pMainOrder."Ship-to Contact" <> pSalesHeader."Ship-to Contact")) then begin
            pSalesHeader."Ship-to Contact" := pMainOrder."Ship-to Contact";
        end;
        //#6313//
        pSalesHeader.Modify;

        //#7067
        wSingleInstance.wSetSalesHeader(pSalesHeader);
        //#7067//
    end;

    procedure fCtrlModifShortCutDim(pFieldNumber: Integer)
    var
        lRecordRefSalesLine: RecordRef;
        lFieldRef: FieldRef;
        lXRecordRefSalesLine: RecordRef;
        lXFieldRef: FieldRef;
        /*GL2024 Le CDU 1 n'existe pas dans BC24. 
        lApplicationManagement: Codeunit ApplicationManagement;*/
        lLastCar: Text[1];
    begin
        //#6737
        lRecordRefSalesLine.GetTable(Rec);
        lFieldRef := lRecordRefSalesLine.Field(pFieldNumber);
        lXRecordRefSalesLine.GetTable(xRec);
        lXFieldRef := lXRecordRefSalesLine.Field(pFieldNumber);
        if (lFieldRef.Value <> lXFieldRef.Value) then begin
            lLastCar := CopyStr(lFieldRef.Name, 20, 1);
            //GL2024  Message(StrSubstNo(TextCtrlModifShortCut, lApplicationManagement.CaptionClassTranslate(WindowsLanguage, '1,2,' + lLastCar)));
        end;
        //#6737//
    end;

    procedure fOpportunityActive() retour: Boolean
    var
        lRelShipMgtSetup: Record "Marketing Setup";
    begin
        //#6968
        retour := false;
        if (lRelShipMgtSetup.Get()) then begin
            retour := (lRelShipMgtSetup."Default Sales Cycle Code" <> '') and
                      (lRelShipMgtSetup."Opportunity Nos." <> '');
        end;
        //#6968//
    end;

    procedure fAddBoqHeader(pSalesHeader: Record "Sales Header")
    var
        lRiderSalesHeader: Record "Sales Header";
        lBoqMgt: Codeunit "BOQ Management";
        lRecordIDFrom: RecordID;
        lRecordIDTo: RecordID;
        lRecRefFrom: RecordRef;
        lRecRefTo: RecordRef;
        lBoqCust: Codeunit "BOQ Custom Management";
    begin
        //#7202
        // Uniquement sur devis et que avenanant different de rien
        if ((pSalesHeader."Document Type" = pSalesHeader."document type"::Quote) and
           (pSalesHeader."Rider to Order No." <> '')) then begin
            // Recuperation du document "Rider to ORder No."
            lRiderSalesHeader.SetRange("No.", pSalesHeader."Rider to Order No.");
            lRiderSalesHeader.SetRange("Document Type", lRiderSalesHeader."document type"::Order);
            if (not lRiderSalesHeader.IsEmpty) then begin
                lRiderSalesHeader.FindFirst;
                // Obtention des recordID
                lRecRefFrom.GetTable(lRiderSalesHeader);
                lRecRefTo.GetTable(pSalesHeader);
                lRecordIDFrom := lRecRefFrom.RecordId;
                lRecordIDTo := lRecRefTo.RecordId;
                // Et bien, copions maintenant
                if not lBoqMgt.Load(lRecRefTo.RecordId) then
                    lBoqCust.gVerifySalesBOQ(Rec);
                if (lBoqMgt.CopyBOQFrom(lRecordIDFrom, lRecordIDFrom, lRecordIDTo, lRecordIDTo, false)) then begin
                    lBoqMgt.Save('');
                end;

            end;
        end;
        //#7202//
    end;

    procedure "// DSFT DA"()
    begin
    end;

    procedure verifDemandeApprobation(CodeUtilisateur: Code[10]; SalesHeader: Record "Sales Header"): Boolean
    var
        UserSetup: Record "User Setup";
        TEXT01: label 'Vous n''avez pas le droit d''approber ce document';
        TEXT02: label 'Statut doit etre ouvert ';
        SalesHead: Record "Sales Header";
    begin
        /*
        IF UserSetup.GET(CodeUtilisateur) THEN
          IF NOT UserSetup."Visa CSA" THEN
              ERROR(TEXT01)
          ELSE
           IF SalesHead.Approval=SalesHead.Approval::Accepté THEN
                  EXIT(TRUE);
           IF  SalesHead.Approval=SalesHead.Approval::Refusé THEN
             IF (SalesHead.Status=SalesHead.Status::Released) AND( SalesHead.Approber= TRUE)  THEN
                     // ERROR(TEXT02)
                     EXIT(FALSE)
        
        
        */

    end;

    procedure VerifSeuilApprobation(RecSalesLine: Record "Sales Line"): Boolean
    var
        RecItem: Record Item;
        MontantLigne: Decimal;
    begin
        if RecSalesLine.Type = RecSalesLine.Type::Item then
            if RecItem.Get(RecSalesLine."No.") then begin
                MontantLigne := RecSalesLine.Quantity * RecItem."Last Direct Cost";
                if MontantLigne > RecItem."Approval threshold requisition" then
                    exit(true)
            end;
    end;

    var
        // lRecordref: RecordRef;
        // lJob: Record 8004160;
        "//HJ SORO": Integer;
        RecLCustomerPostingGroup: Record "Customer Posting Group";
        //  lSalesLine: Record "Sales Line";
        lModifySalesCond: Boolean;
        //  lContact: Record Contact;
        lPrepaymentManagement: Codeunit "Prepayment Management";

        // lxRec: Record "Sales Line";
        //   lCustPostingGp: Record "Customer Posting Group";

        lSingleinstance: Codeunit "Import SingleInstance2";
        Opp2: Record Opportunity;
        lCode: Record Code;
        lInvScheduler: Record "Invoice Scheduler";
        lDescriptionLine: Record "Description Line";
        lSalesOverhead: Record "Sales Overhead-Margin";
        lArchiveDoc: Boolean;
        lOppEntry: Record "Opportunity Entry";
        lRMCommentLine: Record "Rlshp. Mgt. Comment Line";
        lToDo: Record "To-do";
        lCloseOppCode: Record "Close Opportunity Code";
        lJobBudgetEntry: Record "Job Planning Line";
        // lStatus: Option;
        lSalesLine2: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
        lTransferOrderLink: Record "Transfer Order Link";
        lSalesHeader: Record "Sales Header";
        lOldDocumentNo: Code[20];
        //DYS REPORT addon non migrer
        //lSalesToJobBudgetEntry: Report 8004052;
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lRespCenter: Record "Responsibility Center";
        lMaskMgt: Codeunit "Mask Management";
        Text8001400: label 'Do you want to archive the quote?';
        Text8001401: label 'You must choose the loss reason.';
        tArchiveOK: label 'Document %1 has been archived.';
        gLicensePermission: Record "License Permission";
        gSubscrIntegration: Codeunit "Sales Subscription Integr.";
        wArchiveManagement: Codeunit ArchiveManagement;
        wSalesContributor: Record "Sales Contributor";
        wNaviBatSetup: Record NavibatSetup;
        wJob: Record Job;
        WhseSourceHeader: Codeunit 5781;
        wStatisticSetup: Record "Statistics setup";
        wSingleInstance: Codeunit "Import SingleInstance2";
        Text065: label 'DA Lancé Suppression Impossible';
        Text066: label 'Suppression Impossible, Consulter Votre Administrateur';
        Text088: label 'Veuillez Remplir Toutes Les Quantités';
        Text090: label 'Il ya rien a approber !!!';
        Text089: label 'Veuillez Choisir un article';
        Text8003901: label '%1 Status';
        Text8003905: label 'Vous ne pouvez pas modifier %1. Une facture existe déjà.';

        Text8003906: label 'Vous devez supprimer l’achèvement avant de modifier %2.';

        Text8003907: label 'Voulez-vous copier les informations de la commande %1 ?';

        TextRespCenter: label 'La modification de %1 peut changer la numérotation.';

        TextSynchro: label ' Voulez-vous remplacer %1 %2 par %3 dans %4 %5 ?';

        tModifySalesCond: label 'Voulez-vous conserver les conditions de vente (tarification, conditions de paiement, devise, TVA…) ? \ATTENTION: dans le cas contraire, les lignes seront recréées.';

        tNoChangeJob: label 'Impossible de modifier pour une commande.';

        tExternalDocExists: label 'La vente %1 %2 existe déjà pour ce client.';

        TextSynchro2: label 'Voulez-vous remplacer %1 %2 par %3 dans tous les documents de vente du N° de projet %4 ?';
        wDeleteInternalOrderLink: Boolean;
        tRiderToOrder: label 'Vous ne pouvez pas lier une commande à un livreur.';
        TextContractType: label 'Quote Footer Lines already exist, Contract linked lines have not been added.';
        TextCtrlModifShortCut: label 'Modifications of this value %1 require rating calculation of statistic window';
        RecJob: Record Job;
        "// HJ": Integer;
        "Véhicule": Record "Véhicule";
        //GL2024   User: Record 2000000002;
        Demandeur: Record Demandeur;
        UserSetup: Record "User Setup";
        //"// HJ SORO": ;
        Text070: label 'Affecation Magasin Obligatoire Pour Affaire %1';
        "// RB SORO BETON": Integer;
        RecSalesLineBeton: Record "Sales Line";
        RecUserSetup: Record "User Setup";
        RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
        Job: Record Job;
        SalesContributor: Record "Sales Contributor";
        Text071: label 'Approbation Interdite pour l''Utilisateur %1, Consulter votre administrateur';

        // HideValidationDialog: Boolean;

        Text031: label 'Vous avez modifié %1.';
        Text032: label 'Voulez-vous mettre à jour les lignes ?';
        Text004: label 'Voulez-vous changer %1 ?';
        Confirmed: Boolean;
        Text028: label 'Vous ne pouvez pas changer le %1 lorsque le %2 a été rempli.';
}

