Page 50063 "Historique Loyer"
{
    //     DelayedInsert = true;
    //     PageType = List;
    //     SourceTable = Loyer;
    //     SourceTableView = where("Fin Contrat" = const(true));
    //     ApplicationArea = all;
    //     UsageCategory = Lists;
    //     Caption = 'Historique Loyer';
    //     layout
    //     {
    //         area(content)
    //         {
    //             repeater(Control1)
    //             {
    //                 Editable = false;
    //                 ShowCaption = false;
    //                 field("A Régler"; rec."A Régler")
    //                 {
    //                     ApplicationArea = all;
    //                     Visible = "A RéglerVisible";
    //                 }
    //                 field(Chantier; rec.Chantier)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Nom Chantier"; rec."Nom Chantier")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Proprietaire Ancien Code"; rec."Proprietaire Ancien Code")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(Proprietaire; rec.Proprietaire)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Nom Proprietaire"; rec."Nom Proprietaire")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("N° CIN"; rec."N° CIN")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(Adresse; rec.Adresse)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Code Appartement"; rec."Code Appartement")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Nombre Chambre"; rec."Nombre Chambre")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(Residants; Residants)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Residants';

    //                     trigger OnAssistEdit()
    //                     begin
    //                         RecResidants.SetRange(Chantier, rec.Chantier);
    //                         RecResidants.SetRange(Proprietaire, rec.Proprietaire);
    //                         RecResidants.SetRange("Code Appartement", rec."Code Appartement");
    //                         page.RunModal(page::Provisoire, RecResidants);
    //                     end;
    //                 }
    //                 field("Mensualité"; rec.Mensualité)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(GAZ; rec.GAZ)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(Electricite; rec.Electricite)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(Eau; rec.Eau)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(Caution; rec.Caution)
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Date Debut"; rec."Date Debut")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Date Fin"; rec."Date Fin")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field("Fin Contrat"; rec."Fin Contrat")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(Reouvrir)
    //             {
    //                 ApplicationArea = all;
    //                 Caption = 'Reouvrir';
    //                 Promoted = true;
    //                 PromotedCategory = Process;

    //                 trigger OnAction()
    //                 begin
    //                     if not Confirm(Text001) then exit;
    //                     rec."Fin Contrat" := false;
    //                     rec.Modify;
    //                 end;
    //             }
    //             action(Valider)
    //             {
    //                 ApplicationArea = all;
    //                 Caption = 'Valider';
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 Visible = false;

    //                 trigger OnAction()
    //                 begin
    //                     if not Confirm(Text001) then exit;
    //                     if RecPaymentHeader.Get(NumPaiement) then;
    //                     //PaymentLine2.SETRANGE("No.",NumPaiement);
    //                     //IF  PaymentLine2.FINDLAST THEN Compteur:=PaymentLine2."Line No.";
    //                     Compteur := NumLigne;
    //                     if Compteur = 0 then Compteur := 10000;
    //                     RecLoyer.Copy(Rec);
    //                     RecLoyer.SetRange("A Régler", true);
    //                     if RecLoyer.FindFirst then
    //                         repeat
    //                             PaymentLine."No." := NumPaiement;
    //                             PaymentLine."Line No." := Compteur;
    //                             DateEch := Dmy2date(Date2dmy(RecLoyer."Date Debut", 1), Date2dmy(RecPaymentHeader."Posting Date", 2),
    //                             Date2dmy(RecPaymentHeader."Posting Date", 3));
    //                             PaymentLine.Validate("Type de compte", PaymentLine."type de compte"::Vendor);
    //                             PaymentLine.Validate("Code compte", RecLoyer.Proprietaire);
    //                             PaymentLine.Validate("Debit Amount", RecLoyer.Mensualité);
    //                             PaymentLine.Validate("Due Date", DateEch);
    //                             PaymentLine.Chantier := RecLoyer.Chantier;
    //                             if not PaymentLine.Insert(true) then PaymentLine.Modify;
    //                             Compteur += 10000;
    //                             RecLoyer."A Régler" := false;
    //                             RecLoyer.Modify;
    //                         until RecLoyer.Next = 0;
    //                     CurrPage.Close;
    //                 end;
    //             }
    //         }
    //     }

    //     trigger OnInit()
    //     begin
    //         "A RéglerVisible" := true;
    //     end;

    //     trigger OnOpenPage()
    //     begin
    //         if CurrPage.LookupMode then
    //             "A RéglerVisible" := true
    //         else
    //             "A RéglerVisible" := false;
    //     end;

    //     var
    //         RecPaymentHeader: Record "Payment Header";
    //         PaymentLine: Record "Payment Line";
    //         PaymentLine2: Record "Payment Line";
    //         NumPaiement: Code[20];
    //         RecLoyer: Record Loyer;
    //         Compteur: Integer;
    //         DateEch: Date;
    //         Text001: label 'Confirmer cette Action ?';
    //         NumLigne: Integer;
    //         Residants: Code[20];
    //         RecResidants: Record Residants;
    //         FrmResidants: Page Provisoire;
    //         [InDataSet]
    //         "A RéglerVisible": Boolean;


    //     procedure GetNumPaiement(ParaNumPaiement: Code[20]; ParaNumLigne: Integer)
    //     begin
    //         NumPaiement := ParaNumPaiement;
    //         NumLigne := ParaNumLigne;
    //     end;
}

