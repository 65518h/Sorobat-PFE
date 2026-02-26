TableExtension 50012 VendorEXT extends Vendor
{
    fields
    {

        /* modify("Payment Terms Code")
         {
            /* trigger OnAfterValidate()
             var
             begin
                 // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE FOURNISSEUR
                 IF RecCopieTableFournisseur.GET("No.") THEN BEGIN
                     IF "Payment Terms Code" <> '' THEN BEGIN
                         RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                         RecCopieTableFournisseur.MODIFY;
                     END;
                 END
                 ELSE BEGIN
                     // Nouvelle Insertion
                     RecCopieTableFournisseur."No." := "No.";
                     RecCopieTableFournisseur.Name := Name;
                     RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                     RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                     RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                     RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                     RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                     RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                     RecCopieTableFournisseur.Activité := Activité;
                     IF NOT RecCopieTableFournisseur.INSERT THEN RecCopieTableFournisseur.MODIFY;
                     // Nouvelle Insertion
                 END;
                 // RB SORO 20/10/2015
             end;
         }*/
        /*  modify("Country/Region Code")
          {
              trigger OnAfterValidate()
              var
              begin
                  // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE FOURNISSEUR
                  IF RecCopieTableFournisseur.GET("No.") THEN BEGIN
                      IF "Country/Region Code" <> '' THEN BEGIN
                          RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                          RecCopieTableFournisseur.MODIFY;
                      END;
                  END
                  ELSE BEGIN
                      // Nouvelle Insertion
                      RecCopieTableFournisseur."No." := "No.";
                      RecCopieTableFournisseur.Name := Name;
                      RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                      RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                      RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                      RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                      RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                      RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                      RecCopieTableFournisseur.Activité := Activité;
                      IF NOT RecCopieTableFournisseur.INSERT THEN RecCopieTableFournisseur.MODIFY;
                  END;
                  // RB SORO 20/10/2015
              end;
          }*/


        /* modify("Payment Method Code")
         {
             trigger OnAfterValidate()
             var
             begin
                 // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE FOURNISSEUR
                 IF RecCopieTableFournisseur.GET("No.") THEN BEGIN
                     IF "Payment Method Code" <> '' THEN BEGIN
                         RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                         RecCopieTableFournisseur.MODIFY;
                     END;
                 END
                 ELSE BEGIN
                     // Nouvelle Insertion
                     RecCopieTableFournisseur."No." := "No.";
                     RecCopieTableFournisseur.Name := Name;
                     RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                     RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                     RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                     RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                     RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                     RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                     RecCopieTableFournisseur.Activité := Activité;
                     IF NOT RecCopieTableFournisseur.INSERT THEN RecCopieTableFournisseur.MODIFY;
                     // Nouvelle Insertion
                 END;
                 // RB SORO 20/10/2015
             end;
         }*/


        /*  modify("VAT Registration No.")
          {
              trigger OnAfterValidate()
              var
              begin
                  Tmp1CodeFiscal := DELCHR("VAT Registration No.", '=', ' ');
                  Tmp2CodeFiscal := DELCHR(Tmp1CodeFiscal, '=', '/');
                  Tmp3CodeFiscal := DELCHR(Tmp2CodeFiscal, '=', '\');
                  Tmp4CodeFiscal := DELCHR(Tmp3CodeFiscal, '=', '-');
                  CodeFiscal := UPPERCASE(Tmp4CodeFiscal);
                  IF "Type identifiant" = 0 THEN ERROR(Text014);
                  IF "Type identifiant" = "Type identifiant"::CIN THEN
                      IF STRLEN(CodeFiscal) <> 8 THEN ERROR(Text012);
                  IF "Type identifiant" = "Type identifiant"::"Matricule Fiscal" THEN
                      IF STRLEN(CodeFiscal) <> 13 THEN ERROR(Text013);
                  Vendor.SETRANGE("VAT Registration No.", CodeFiscal);
                  IF Vendor.FINDFIRST THEN ERROR(Text015);
                  //VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Vendor);
                  "VAT Registration No." := CodeFiscal;
                  // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE FOURNISSEUR
                  IF RecCopieTableFournisseur.GET("No.") THEN BEGIN
                      IF "VAT Registration No." <> '' THEN BEGIN
                          RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                          RecCopieTableFournisseur.MODIFY;
                      END;
                  END
                  ELSE BEGIN
                      // Nouvelle Insertion
                      RecCopieTableFournisseur."No." := "No.";
                      RecCopieTableFournisseur.Name := Name;
                      RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                      RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                      RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                      RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                      RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                      RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                      RecCopieTableFournisseur.Activité := Activité;
                      IF NOT RecCopieTableFournisseur.INSERT THEN RecCopieTableFournisseur.MODIFY;
                  END;
                  // RB SORO 20/10/2015

              end;
          }*/






        field(50000; "Default Bank Account Code1"; Code[10])
        {
            Caption = 'Default Bank Account Code';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("No."));
        }
        field(50001; "Payment in progress (LCY)1"; Decimal)
        {
            CalcFormula = sum("Payment Line"."Amount (LCY)" where("Account Type" = const(Vendor),
                                                                   "Account No." = field("No."),
                                                                   "Copied To Line" = const(0),
                                                                   "Payment in Progress" = const(true)));
            Caption = 'Payment in progress (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; Statut; Option)
        {
            Description = 'HJ DSFT 24-03-2012';
            Editable = false;
            OptionMembers = "En Attente","Validé";

            trigger OnValidate()
            begin
                CheckFields;
            end;
        }
        field(50003; "Ancien Numero"; Code[20])
        {
            Description = 'HJ DSFT 27-04-2012';
            Editable = true;
        }
        field(50004; Qualite; Integer)
        {
            Caption = 'Qualite';
        }
        field(50005; "Compte Contribuable"; Code[20])
        {
            Description = 'HJ DSFT 05-10-2012';
        }
        field(50006; "Regime D'imposition"; Option)
        {
            Description = 'HJ DSFT 05-10-2012';
            OptionMembers = ,Synthetique,"Réel Simplifié","Réel Normal",Informel;

            /* trigger OnValidate()
             begin
                 // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE FOURNISSEUR
                 if RecCopieTableFournisseur.Get("No.") then begin
                     if "Regime D'imposition" <> "regime d'imposition"::" " then begin
                         RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                         RecCopieTableFournisseur.Modify;
                     end;
                 end
                 else begin
                     // Nouvelle Insertion
                     RecCopieTableFournisseur."No." := "No.";
                     RecCopieTableFournisseur.Name := Name;
                     RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                     RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                     RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                     RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                     RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                     RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                     RecCopieTableFournisseur.Activité := Activité;
                     if not RecCopieTableFournisseur.Insert then RecCopieTableFournisseur.Modify;
                 end;
                 // RB SORO 20/10/2015
             end;*/
        }
        field(50007; "Cente D'imposition"; Code[20])
        {
            Description = 'HJ DSFT 05-10-2012';
        }
        field(50008; Synchronise; Boolean)
        {
        }
        field(50009; "Activité"; text[50])
        {

            /*   trigger OnValidate()
               begin
                   // RB SORO 20/10/2015 GARDR L'INFORMATION DS LA TABLE COPIE TABLE FOURNISSEUR
                   if RecCopieTableFournisseur.Get("No.") then begin
                       if "Type identifiant" <> "type identifiant"::" " then begin
                           RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                           RecCopieTableFournisseur.Modify;
                       end;
                   end
                   else begin
                       // Nouvelle Insertion
                       RecCopieTableFournisseur."No." := "No.";
                       RecCopieTableFournisseur.Name := Name;
                       RecCopieTableFournisseur."Payment Terms Code" := "Payment Terms Code";
                       RecCopieTableFournisseur."Country/Region Code" := "Country/Region Code";
                       RecCopieTableFournisseur."Payment Method Code" := "Payment Method Code";
                       RecCopieTableFournisseur."VAT Registration No." := "VAT Registration No.";
                       RecCopieTableFournisseur."Regime D'imposition" := "Regime D'imposition";
                       RecCopieTableFournisseur."Type identifiant" := "Type identifiant";
                       RecCopieTableFournisseur.Activité := Activité;
                       if not RecCopieTableFournisseur.Insert then RecCopieTableFournisseur.Modify;
                   end;
                   // RB SORO 20/10/2015
               end;*/
        }
        field(50010; "Num Sequence Syncro"; Integer)
        {


        }
        field(50011; "Cheque En Circulation"; decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Payment Line".Amount WHERE("Copied To No." = FILTER(''), "Payment Class" = FILTER('CHEQUE EMIS' | 'CHEQUE CERTIFIE'), "Status No." = CONST(30000), "Account No." = FIELD("No.")));

        }
        field(50012; "Effet En Circulation"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Payment Line".Amount WHERE("Copied To No." = FILTER(''),
                                                                                                "Payment Class" = FILTER('EFFET EMIS' | 'EFFET AVALISEE'),
                                                                                                "Status No." = CONST(30000),
                                                                                                "Account No." = FIELD("No.")));
        }
        field(50013; Transporteur; Boolean)
        {
        }
        field(50014; "Creer Par"; Code[20])
        {
        }
        field(50015; "En Cours De Signature"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Copied To No." = filter(''),
                                                                    "Acc. No. Last Entry Debit" = filter(''),
                                                                    "Account No." = field("No."),
                                                                    "Payment Class" = filter('AVANCE-FRS-CHEQ' | 'AVANCE-FRS-TRT' | 'PAIEMENT'),
                                                                    "Status No." = const(6500)));
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-04-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "Reglement Valide"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Entry Type" = filter("Initial Entry"),
                                                                          "Document Type" = filter(" "),
                                                                          "Vendor No." = field("No.")));
            Description = 'RB SORO 26/03/2015  = Montant des Reglement validé';
            FieldClass = FlowField;
        }
        field(50017; "Total Avance"; Decimal)
        {
            CalcFormula = sum("Payment Line".Amount where("Payment Class" = filter('AVANCE-FRS'),
                                                           "Account No." = field("No."),
                                                           "Status No." = filter(> 5000)));
            Description = 'RB SORO 26/03/2015  = Montant des Avance validé';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Traite Non Echu"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Copied To No." = filter(''),
                                                                    "Account No." = field("No."),
                                                                    //GL2024     "Payment Class" = const('DECAISS-TRAITE'),
                                                                    "Payment Class" = filter('DECAISS-TRAITE' | 'DECAISS-TRAITE-AVAL'),
                                                                    "Status No." = const(10000),
                                                                    "Due Date" = field("Filtre Date Ech")));
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-04-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Filtre Date Ech"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50020; "Avance Non Lettré"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = false;
            /*  trigger OnLookup()
              begin
                  VendoredgerEntry.SETRANGE("Vendor No.", "No.");
                  //VendoredgerEntry.SETFILTER("Document No.",'AVFACT*');
                  //VendoredgerEntry.SETFILTER("Document No.",'AV*');
                  VendoredgerEntry.SETFILTER("Document No.", '%1|%2', 'AV*', 'DTAV*');
                  VendoredgerEntry.SETRANGE(Open, TRUE);
                  IF Page.RUNMODAL(Page::"Vendor Ledger Entries", VendoredgerEntry) = ACTION::LookupOK THEN;
              end;*/


        }
        field(50021; "Filtre Document"; Code[20])
        {
            Description = 'HJ SORO 13-04-2015';
            FieldClass = FlowFilter;
        }
        field(50022; "Signé"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Copied To No." = filter(''),
                                                                    "Acc. No. Last Entry Debit" = filter(''),
                                                                    "Account No." = field("No."),
                                                                    "Payment Class" = filter('AVANCE-FRS-CHEQ' | 'AVANCE-FRS-TRT' | 'PAIEMENT' | 'DECAISS-TRAITE-AVAL'),
                                                                    "Status No." = const(6000)));
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-04-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Factures En Cours"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amount Including VAT" where("Document Type" = const(Invoice),
                                                                            "Buy-from Vendor No." = field("No.")));
            Description = 'HJ SORO 27-06-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Total Paiement"; Decimal)
        {
            CalcFormula = sum("Payment Line".Amount where("Account No." = field("No."),
                                                           "Account Type" = const(Vendor),
                                                           "Copied To No." = filter('')));
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 27-06-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Réglement en Préparation"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Copied To No." = filter(''),
                                                                    "Acc. No. Last Entry Debit" = filter(''),
                                                                    "Account No." = field("No."),
                                                                    "Payment Class" = filter('AVANCE-FRS-CHEQ' | 'AVANCE-FRS-TRT' | 'PAIEMENT' | 'DECAISS-TRAITE-AVAL'),
                                                                    "Status No." = const(5000)));
            Description = 'MH SORO 15-02-2018';
            FieldClass = FlowField;
        }
        field(50026; "Réglement Préparé"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Copied To No." = filter(''),
                                                                    "Acc. No. Last Entry Debit" = filter(''),
                                                                    "Account No." = field("No."),
                                                                    "Payment Class" = filter('AVANCE-FRS-CHEQ' | 'AVANCE-FRS-TRT' | 'PAIEMENT'),
                                                                    "Status No." = const(5500)));
            Description = 'MH SORO 15-02-2018';
            FieldClass = FlowField;
        }
        field(50027; "Controle Financier en Cours"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Copied To No." = filter(''),
                                                                    "Acc. No. Last Entry Debit" = filter(''),
                                                                    "Account No." = field("No."),
                                                                    "Payment Class" = filter('AVANCE-FRS-CHEQ' | 'AVANCE-FRS-TRT' | 'PAIEMENT'),
                                                                    "Status No." = const(16000)));
            Description = 'MH SORO 15-02-2018';
            FieldClass = FlowField;
        }
        field(50028; RIB; Code[30])
        {
            Description = 'MH SORO 09-03-2018';
        }
        field(50029; Banque; Option)
        {
            Description = 'MH SORO 09-03-2018';
            OptionMembers = " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA,BIAT,STUCID,CCP,"AMEN BANK","WIFAK BANK",TSB,"ALBARAKA BANK";
        }
        field(50030; "Code Retenue à la Source"; Code[10])
        {
            Description = 'MH SORO 13-02-2023';
            /*  TableRelation = "Groupe Retenue".Code where("Type Retenue" = filter("à la source"),
                                                           Proposition = filter(Fournisseurs));*/
        }
        field(50031; "Autoriser Avance"; Boolean)
        {
            Description = 'MH SORO 03-05-2023';
        }
        //NEW
        field(50032; "Date de Naissance"; date)
        {

        }
        field(50800; "Appliquer Fodec"; Boolean)
        {
            Description = 'RB SORO 07/04/2015';
        }
        field(50170; "Type Fournisseur"; Option)
        {
            OptionCaption = ' ,Non Résident physique,Non Résident Morale,Résident Morale,Résident Physique,Régime réel';
            OptionMembers = " ","Non Résident physique","Non Résident Morale","Résident Morale","Résident Physique","Régime réel";
        }
        field(51000; "Address Soroubat"; text[100])
        {

        }
        /*field(50999; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';

        }*/
        //GL2024 Declaration Employeur
        field(65009; Activite; Text[40])
        {
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(99998; "Suggest Payments"; Boolean)
        {
            Caption = 'Suggest Payments';
            Description = '2000005';
            InitValue = true;
        }
        field(99999; "Purchases (LCY)2"; decimal)
        {
            Caption = 'Achats DS';
            Editable = false;
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = - Sum("Vendor Ledger Entry"."Purchase (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                                                  "Currency Code" = FIELD("Currency Filter")));
        }
        field(8001400; Cotation; Code[10])
        {
            Caption = 'Cotation';
            TableRelation = Code.Code where("Table No" = filter(23),
                                             "Field No" = filter(8001400));
        }
        field(8003901; "External Work Force"; Boolean)
        {
            Caption = 'External Work Force';
        }
        field(8003902; "Shipment Method to"; Text[30])
        {
            Caption = 'Shipment Method to';
        }
        field(8003905; "Import Priority"; Integer)
        {
            Caption = 'Import Priority';
        }
        field(8004090; "Vendor Disc. Group"; Code[10])
        {
            Caption = 'Vendor Discount Group';
            TableRelation = "Vendor Discount Group";
        }
        field(8004091; "Item Category"; Boolean)
        {
            CalcFormula = exist("Vendor Item Category Group" where("Vendor No." = field("No."),
                                                                    "Item Category Code" = field("Item Category Filter")));
            Caption = 'Item Category';
            FieldClass = FlowField;
        }
        field(8004092; "Item Category Filter"; Code[20])
        {
            Caption = 'Filtre catégorie article';
            FieldClass = FlowFilter;
            TableRelation = "Item Category";
        }
        field(8004150; Subcontractor; Boolean)
        {
            Caption = 'Subcontractor';
        }
    }
    keys
    {
        key(Key17; "Import Priority")
        {
        }
        key(Key18; Synchronise)
        {
        }
        key(Key19; "Ancien Numero")
        {
        }
    }

    trigger OnBeforeInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        DimMgt2: Codeunit DimensionManagement;

        IsHandled: Boolean;
        NoSeries: Codeunit "No. Series";
    begin
        if "No." = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Vendor Nos.");
#if not CLEAN24
            NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(PurchSetup."Vendor Nos.", xRec."No. Series", 0D, "No.", "No. Series", IsHandled);
            //  if not IsHandled then begin
#endif
            "No. Series" := PurchSetup."Vendor Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Vendor.ReadIsolation(IsolationLevel::ReadUncommitted);
            Vendor.SetLoadFields("No.");
            while Vendor.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");
#if not CLEAN24
            NoSeriesMgt.RaiseObsoleteOnAfterInitSeries("No. Series", PurchSetup."Vendor Nos.", 0D, "No.");
            // end;
#endif
        end;

        if "Invoice Disc. Code" = '' then
            "Invoice Disc. Code" := "No.";

        // if (not (InsertFromContact or (InsertFromTemplate and (Contact <> '')))) or ForceUpdateContact then
        //   UpdateContFromVend.OnInsert(Rec);

        if "Purchaser Code" = '' then
            SetDefaultPurchaser();

        DimMgt2.UpdateDefaultDim(
          DATABASE::Vendor, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        UpdateReferencedIds();
        SetLastModifiedDateTime();

    end;

    trigger OnafterInsert()
    var
    begin
        //GL2024     //il n'y a pas d'event pour Pour empêcher l'entrée ou supprimer code standard
        // IF NOT InsertFromContact THEN
        // UpdateContFromCust.OnInsert(Rec); //GL2024FIN
        //REPLIC

        //+REF+TEMPLATE
        DimMgt.fSetDefaultDim(DATABASE::Vendor, "No.", 1, "Global Dimension 1 Code");
        DimMgt.fSetDefaultDim(DATABASE::Vendor, "No.", 2, "Global Dimension 2 Code");
        //+REF+TEMPLATE//


        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //REPLIC//
        "Creer Par" := UPPERCASE(USERID);
    end;

    trigger OnafterModify()
    var
        lReplicationRef: RecordRef;

    begin
        //REPLIC
        wReplicationRef.GETTABLE(Rec);
        lReplicationRef.GETTABLE(xRec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //REPLIC//
    end;

    trigger OnbeforeDelete()
    begin
        EXIT;
    end;

    trigger OnafterDelete()
    var

    begin
        //REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //REPLIC//
    end;

    trigger OnafterRename()
    var
        lReplicationRef: RecordRef;
    begin

        //REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //REPLIC//
    end;


    procedure fShowContactList()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then
            exit;
        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.Find('-') then begin
            if not Confirm(Text003, false, TableCaption, "No.") then
                exit;
            UpdateContFromVend.InsertNewContact(Rec, false);
            ContBusRel.Find('-');
        end;
        Commit;

        Cont.SetCurrentkey("Company No.");
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        if page.RunModal(page::"Contact List", Cont) = Action::LookupOK then
            page.Run(page::"Contact Card", Cont);
    end;

    procedure "// HJ DSFT"()
    begin
    end;

    procedure CheckFields()
    var
        TemplateMgt: Codeunit SoroubatFucntion;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        TemplateMgt.CheckMandatoriesFields(RecRef);
    end;

    var
        lVendItemCatGroup: Record "Vendor Item Category Group";
        lDescriptionLine: Record "Description Line";

        lReplicationRef: RecordRef;

        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        Text012: label 'Format CIN Incorrect (8 Nombre Au Minimuim)';
        Text013: label 'Format Matricule Fiscale Incorrecte (13 Caractéres Au Minimuim)';
        Text014: label 'Veuillez Specifier Type Identifiant';
        "// HJ SORO": Integer;
        Vendor: Record Vendor;
        Text015: label 'Code Deja Saisie';
        CodeFiscal: Code[20];
        Tmp1CodeFiscal: Code[20];
        Tmp2CodeFiscal: Code[20];
        Tmp3CodeFiscal: Code[20];
        Tmp4CodeFiscal: Code[20];
        VendoredgerEntry: Record "Vendor Ledger Entry";
        "// RB SORO 20/10/2015": Integer;
        //GL2024   RecCopieTableFournisseur: Record "Copie Table Fournisseur";

        UpdateContFromVend: Codeunit "VendCont-Update";

        DimMgt: Codeunit DimensionManagementEvent;

        Text003: label 'Do you wish to create a contact for %1 %2?';
}

