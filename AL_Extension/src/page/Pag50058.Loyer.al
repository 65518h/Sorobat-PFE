Page 50058 Loyer
{
    // DelayedInsert = true;
    // PageType = List;
    // SourceTable = Loyer;
    // SourceTableView = where("Fin Contrat" = const(false));
    // ApplicationArea = all;
    // UsageCategory = Lists;
    // Caption = 'Parametrage Loyer';

    // layout
    // {
    //     area(content)
    //     {
    //         repeater(Control1)
    //         {
    //             ShowCaption = false;
    //             field("A Régler"; rec."A Régler")
    //             {
    //                 ApplicationArea = all;
    //                 Visible = "A RéglerVisible";
    //             }
    //             field("Integrer Caution"; rec."Integrer Caution")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field(Chantier; rec.Chantier)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Nom Chantier"; rec."Nom Chantier")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Proprietaire Ancien Code"; rec."Proprietaire Ancien Code")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field(Proprietaire; rec.Proprietaire)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Nom Proprietaire"; rec."Nom Proprietaire")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("N° CIN"; rec."N° CIN")
    //             {
    //                 ApplicationArea = all;
    //                 Editable = false;
    //             }
    //             field(Adresse; rec.Adresse)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Code Appartement"; rec."Code Appartement")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Nombre Chambre"; rec."Nombre Chambre")
    //             {
    //                 ApplicationArea = all;

    //                 trigger OnValidate()
    //                 begin
    //                     if rec."Nombre Chambre" = 0 then rec."Nombre Chambre" := 1;
    //                 end;
    //             }
    //             field(Residants; Residants)
    //             {
    //                 ApplicationArea = all;
    //                 Caption = 'Residants';

    //                 trigger OnAssistEdit()
    //                 begin
    //                     RecResidants.SetRange(Chantier, rec.Chantier);
    //                     RecResidants.SetRange(Proprietaire, rec.Proprietaire);
    //                     RecResidants.SetRange("Code Appartement", rec."Code Appartement");
    //                     page.RunModal(page::Provisoire, RecResidants);
    //                 end;
    //             }
    //             field("Type Contrat"; rec."Type Contrat")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Mensualité"; rec.Mensualité)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Montant Annuelle"; rec."Montant Annuelle")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field(Caution; rec.Caution)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field(GAZ; rec.GAZ)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field(Electricite; rec.Electricite)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field(Eau; rec.Eau)
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Date Debut"; rec."Date Debut")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Date Fin"; rec."Date Fin")
    //             {
    //                 ApplicationArea = all;
    //             }
    //             field("Fin Contrat"; rec."Fin Contrat")
    //             {
    //                 ApplicationArea = all;
    //             }
    //         }
    //     }
    // }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("...")
    //         {
    //             ApplicationArea = all;
    //             Caption = 'A Régler';
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             begin
    //                 if not Confirm(Text001) then exit;
    //                 RecLoyer2.SetRange(Chantier, rec.Chantier);
    //                 if RecLoyer2.FindFirst then
    //                     repeat
    //                         RecLoyer2."A Régler" := true;
    //                         RecLoyer2.Modify;
    //                     until RecLoyer2.Next = 0;
    //             end;
    //         }
    //         action(Valider)
    //         {
    //             ApplicationArea = all;
    //             Caption = 'Valider';
    //             Promoted = true;
    //             PromotedCategory = Process;

    //             trigger OnAction()
    //             begin
    //                 if not Confirm(Text001) then exit;
    //                 if RecPaymentHeader.Get(NumPaiement) then;
    //                 PaymentLine2.SetRange("No.", NumPaiement);
    //                 if PaymentLine2.FindLast then Compteur := PaymentLine2."Line No.";
    //                 if Compteur = 0 then Compteur := 10000;
    //                 RecLoyer.Copy(Rec);
    //                 RecLoyer.SetRange("A Régler", true);
    //                 if RecLoyer.FindFirst then
    //                     repeat
    //                         Compteur += 10000;
    //                         PaymentLine."No." := NumPaiement;
    //                         PaymentLine."Line No." := Compteur;
    //                         DateEch := Dmy2date(Date2dmy(RecLoyer."Date Debut", 1), Date2dmy(RecPaymentHeader."Posting Date", 2),
    //                         Date2dmy(RecPaymentHeader."Posting Date", 3));
    //                         PaymentLine."Date Loyer" := DateEch;
    //                         PaymentLine.Validate("Type de compte", PaymentLine."type de compte"::Vendor);
    //                         PaymentLine.Validate("Code compte", RecLoyer.Proprietaire);
    //                         //GL2024
    //                         PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
    //                         PaymentLine."Code compte" := RecLoyer.Proprietaire;

    //                         PaymentLine.Validate("Account No.", PaymentLine."Code compte");
    //                         //GL2024
    //                         if RecLoyer."Type Contrat" = RecLoyer."type contrat"::Mensuelle then
    //                             PaymentLine.Validate("Debit Amount", RecLoyer.Mensualité)
    //                         else
    //                             PaymentLine.Validate("Debit Amount", RecLoyer."Montant Annuelle");
    //                         // RB SORO 16/10/2017
    //                         RecLoyerPaymentLine.Reset;
    //                         RecLoyerPaymentLine.SetRange("Account No.", RecLoyer.Proprietaire);
    //                         RecLoyerPaymentLine.SetRange(Chantier, RecLoyer.Chantier);
    //                         RecLoyerPaymentLine.SetRange(Appartement, RecLoyer."Code Appartement");
    //                         RecLoyerPaymentLine.SetRange("Date Loyer", DateEch);
    //                         if RecLoyerPaymentLine.FindFirst then Error(Text002, RecLoyer.Proprietaire, RecLoyer."Code Appartement", DateEch);
    //                         // RB SORO 16/10/2017
    //                         PaymentLine.Validate("Date Loyer", DateEch);
    //                         PaymentLine.Chantier := RecLoyer.Chantier;
    //                         PaymentLine.Appartement := RecLoyer."Code Appartement";
    //                         PaymentLine."Payment Class" := RecPaymentHeader."Payment Class";
    //                         PaymentLine.Insert;
    //                         RecLoyer."A Régler" := false;
    //                         RecLoyer.Modify;
    //                     until RecLoyer.Next = 0;
    //                 RecLoyer.Reset;
    //                 RecLoyer.Copy(Rec);
    //                 RecLoyer.SetRange("Integrer Caution", true);
    //                 if RecLoyer.FindFirst then
    //                     repeat
    //                         Compteur += 10000;
    //                         PaymentLine."No." := NumPaiement;
    //                         PaymentLine."Line No." := Compteur;
    //                         DateEch := Dmy2date(Date2dmy(RecLoyer."Date Debut", 1), Date2dmy(RecPaymentHeader."Posting Date", 2),
    //                         Date2dmy(RecPaymentHeader."Posting Date", 3));
    //                         PaymentLine."Date Loyer" := DateEch;
    //                         PaymentLine.Validate("Type de compte", PaymentLine."type de compte"::Vendor);
    //                         PaymentLine.Validate("Code compte", RecLoyer.Proprietaire);
    //                         PaymentLine.Validate("Debit Amount", RecLoyer.Mensualité);
    //                         PaymentLine.Validate("Due Date", DateEch);
    //                         PaymentLine.Chantier := RecLoyer.Chantier;
    //                         PaymentLine.Commentaires := 'CAUTION';
    //                         PaymentLine.Appartement := RecLoyer."Code Appartement";
    //                         PaymentLine.Insert;
    //                         RecLoyer."Integrer Caution" := false;
    //                         RecLoyer.Modify;
    //                     until RecLoyer.Next = 0;

    //                 CurrPage.Close;
    //             end;
    //         }
    //     }
    // }

    // trigger OnInit()
    // begin
    //     "A RéglerVisible" := true;
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     rec."Nombre Chambre" := 1;
    // end;

    // trigger OnOpenPage()
    // begin
    //     if CurrPage.LookupMode then
    //         "A RéglerVisible" := true
    //     else
    //         "A RéglerVisible" := false;
    // end;

    // var
    //     RecPaymentHeader: Record "Payment Header";
    //     PaymentLine: Record "Payment Line";
    //     PaymentLine2: Record "Payment Line";
    //     NumPaiement: Code[20];
    //     RecLoyer: Record Loyer;
    //     RecLoyer2: Record Loyer;
    //     Compteur: Integer;
    //     DateEch: Date;
    //     Text001: label 'Confirmer Cette Action ?';
    //     NumLigne: Integer;
    //     Residants: Code[20];
    //     RecResidants: Record Residants;
    //     FrmResidants: Page Provisoire;
    //     RecLoyerPaymentLine: Record "Payment Line";
    //     Text002: label 'Vérifier la date Loyer, Il existe deja une lignie de Paiement pour le Fournisseur %1 l''appartement N° %2 de date %3';
    //     [InDataSet]
    //     "A RéglerVisible": Boolean;


    // procedure GetNumPaiement(ParaNumPaiement: Code[20]; ParaNumLigne: Integer)
    // begin
    //     NumPaiement := ParaNumPaiement;
    //     NumLigne := ParaNumLigne;
    // end;
}

