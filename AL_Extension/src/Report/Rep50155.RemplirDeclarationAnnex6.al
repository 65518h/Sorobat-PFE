report 50155 "Remplir Declaration Annex 6"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RemplirDeclarationAnnex6.rdlc';

    // dataset
    // {
    //     dataitem("G/L Entry"; 17)
    //     {
    //         DataItemTableView = SORTING("G/L Account No.", "Source No.")
    //                             ORDER(Ascending);
    //         column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
    //         {
    //         }
    //         column(G_L_Entry__Source_Type_; "Source Type")
    //         {
    //         }
    //         column(G_L_Entry__Source_No__; "Source No.")
    //         {
    //         }
    //         column(ROUND_Montant_0_001_; ROUND(Montant, 0.001))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(ROUND_GRecDeclaration__Mnt_Brut__0_001_; ROUND(GRecDeclaration."Mnt Brut", 0.001))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(ROUND_GRecDeclaration__Mnt_Net__0_001_; ROUND(GRecDeclaration."Mnt Net", 0.001))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Entry__G_L_Account_No__Caption; FIELDCAPTION("G/L Account No."))
    //         {
    //         }
    //         column(G_L_Entry__Source_No__Caption; FIELDCAPTION("Source No."))
    //         {
    //         }
    //         column(G_L_Entry__Source_Type_Caption; FIELDCAPTION("Source Type"))
    //         {
    //         }
    //         column("Montant_DéduitCaption"; Montant_DéduitCaptionLbl)
    //         {
    //         }
    //         column(Montant_NetCaption; Montant_NetCaptionLbl)
    //         {
    //         }
    //         column(Montant_BrutCaption; Montant_BrutCaptionLbl)
    //         {
    //         }
    //         column(G_L_Entry_Entry_No_; "Entry No.")
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             Montant := Montant + "G/L Entry".Amount;

    //             CGC := 0;
    //             CLEAR(GRecDeclaration);
    //             // CurrReport.SHOWOUTPUT := CurrReport.TOTALSCAUSEDBY = FIELDNO("G/L Account No.");
    //             // CurrReport.SHOWOUTPUT := CurrReport.TOTALSCAUSEDBY = FIELDNO("Source No.");
    //             GRecDeclaration.Année := Year;
    //             GRecDeclaration."Code Tiers" := "Source No.";
    //             IF GRecVendor.GET("Source No.") THEN BEGIN
    //                 GRecDeclaration."Nom Tiers" := GRecVendor.Name;
    //                 //GRecVendor.TESTFIELD("Matricule fiscale");  
    //                 IF GRecVendor."Type identifiant" = GRecVendor."Type identifiant"::"Matricule Fiscal" THEN
    //                     GRecDeclaration."Code TVA" := GRecVendor."VAT Registration No.";
    //                 GRecDeclaration.Address := GRecVendor.Address;
    //                 IF GRecVendor."Type identifiant" = GRecVendor."Type identifiant"::CIN THEN
    //                     GRecDeclaration."N° CIN" := GRecVendor."VAT Registration No.";
    //             END;
    //             GRecDeclaration.CompteG := "G/L Account No.";
    //             CGC := 0;
    //             GRecParaDec2.SETRANGE(Compte, "G/L Account No.");
    //             IF GRecParaDec2.FINDFIRST THEN BEGIN
    //                 IF GRecParaDec2."Compte CGC" <> '' THEN BEGIN
    //                     GRecDeclaration.SETRANGE("Code Tiers", "Source No.");
    //                     GRecDeclaration.SETFILTER(CGC, '<>%1', 0);
    //                     IF NOT GRecDeclaration.FINDFIRST THEN BEGIN
    //                         GLEntry.SETCURRENTKEY("G/L Account No.", "Source No.");
    //                         GLEntry.SETRANGE("Posting Date", GDateDeb, GDateFin);
    //                         GLEntry.SETRANGE("G/L Account No.", GRecParaDec2."Compte CGC");
    //                         GLEntry.SETRANGE("Source No.", "Source No.");
    //                         IF GLEntry.FINDFIRST THEN
    //                             REPEAT
    //                                 CGC += ABS(GLEntry.Amount);
    //                             UNTIL GLEntry.NEXT = 0;
    //                     END;
    //                 END;
    //             END;
    //             IF GRecVendor.Loyer THEN
    //                 GRecDeclaration.Loyer := TRUE ELSE
    //                 GRecDeclaration.Loyer := FALSE;
    //             GRecDeclaration.CGC := CGC;
    //             GRecDeclaration.MntDeduit := ABS(Montant);
    //             Taux := GetTauxRetenu("G/L Account No.");
    //             GRecDeclaration."Mnt Brut" := 0;
    //             GRecDeclaration."Mnt Net" := 0;
    //             GRecParaDec.RESET;
    //             GRecParaDec.SETFILTER(Compte, "G/L Account No.");
    //             IF GRecParaDec.FIND('-') THEN BEGIN
    //                 IF (Taux <> 0) OR (GRecParaDec.Taux <> 0) THEN BEGIN
    //                     IF Taux <> 0 THEN BEGIN
    //                         GRecDeclaration."Mnt Brut" := 100 * ABS(Montant) / Taux;
    //                         GRecDeclaration."Mnt Net" := GRecDeclaration."Mnt Brut" - ABS(Montant);
    //                     END
    //                     ELSE IF GRecParaDec.Taux <> 0 THEN BEGIN
    //                         GRecDeclaration."Mnt Brut" := 100 * Montant / GRecParaDec.Taux;
    //                         GRecDeclaration."Mnt Net" := GRecDeclaration."Mnt Brut" - ABS(Montant);
    //                     END;
    //                 END;
    //                 GRecDeclaration."Type Declaration" := GRecVendor."Type Fournisseur";
    //                 GRecDeclaration.Annexe := GRecParaDec.Annexe;
    //                 IF GRecDeclaration.Annexe = 0 THEN
    //                     GRecDeclaration.Annexe := GetAnnexe("G/L Account No.");
    //                 GRecDeclaration.Marché := FALSE;//A VOIR
    //                 GRecDeclaration.Position := GRecParaDec.Position;
    //                 GRecDeclaration.Utilisateur := USERID;
    //                 GRecDeclaration."Date modification" := WORKDATE;
    //                 GRecDeclaration.Activité := COPYSTR(GRecVendor.Activité, 1, 40);
    //                 IF (CurrReport.SHOWOUTPUT) AND (GRecDeclaration."Mnt Brut" <> 0) THEN GRecDeclaration.INSERT;
    //             END;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF Year = 0 THEN
    //                 ERROR(Erreur1);

    //             GDateDeb := DMY2DATE(1, 1, Year);
    //             GDateFin := DMY2DATE(31, 12, Year);
    //             SETRANGE("Posting Date", GDateDeb, GDateFin);

    //             GTxtFilterCompte := '';
    //             GCodAccont := '';
    //             i := 0;
    //             //****************
    //             GRecParaDec.RESET;
    //             GRecParaDec.SETRANGE(Annexe, GRecDeclaration.Annexe::"Annexe VI");
    //             //GRecParaDec.SETFILTER(Annexe,FORMAT(CodeAnnexe));
    //             IF GRecParaDec.FIND('-') THEN
    //                 REPEAT
    //                     IF GRecParaDec.Compte <> '' THEN BEGIN
    //                         i := i + 1;
    //                         IF i = 1 THEN BEGIN
    //                             GTxtFilterCompte := GRecParaDec.Compte;
    //                             GCodAccont := GRecParaDec.Compte;
    //                         END
    //                         ELSE
    //                             IF i > 1 THEN
    //                                 IF GRecParaDec.Compte <> GCodAccont THEN BEGIN
    //                                     GTxtFilterCompte := GTxtFilterCompte + '|' + GRecParaDec.Compte;
    //                                     GCodAccont := GRecParaDec.Compte;
    //                                 END

    //                     END;
    //                 UNTIL GRecParaDec.NEXT = 0;
    //             SETFILTER("G/L Account No.", GTxtFilterCompte);
    //             SETFILTER("Source Type", 'Client');
    //             GRecDeclaration.RESET;
    //             GRecDeclaration.SETRANGE(Annexe, GRecDeclaration.Annexe::"Annexe VI");
    //             GRecDeclaration.SETFILTER(Année, '%1', Year);
    //             IF GRecDeclaration.FIND('-') THEN
    //                 REPEAT
    //                     //MESSAGE(GRecDeclaration."Code Client");
    //                     GRecDeclaration.DELETE;
    //                 //  GRecDeclaration.MODIFY;
    //                 UNTIL GRecDeclaration.NEXT = 0;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     GLEntry: Record 17;
    //     Year: Integer;
    //     "Gpe.Retenu.Source": Record 50002;
    //     GDateDeb: Date;
    //     GDateFin: Date;
    //     Erreur1: Label 'Vous devez spécifier l''année';
    //     GRecDeclaration: Record 50027;
    //     GTxtFilterCompte: Text[100];
    //     GCodAccont: Code[20];
    //     i: Integer;
    //     GRecCustomer: Record 18;
    //     Montant: Decimal;
    //     Taux: Decimal;
    //     CA215: Text[30];
    //     AnnA215: Option " ","Annexe II","Annexe III","Annexe VI","Annexe V";
    //     CA216: Text[30];
    //     AnnA216: Option " ","Annexe II","Annexe III","Annexe VI","Annexe V";
    //     CA217: Text[30];
    //     ANNA217: Option " ","Annexe II","Annexe III","Annexe VI","Annexe V";
    //     CA218: Text[30];
    //     AnnA218: Option " ","Annexe II","Annexe III","Annexe VI","Annexe V";
    //     GRecParaDec: Record 50026;
    //     GRecParaDec2: Record 50026;
    //     CodeAnnexe: Option " ","Annexe II","Annexe III","Annexe VI","Annexe V";
    //     CGC: Decimal;
    //     "Montant_DéduitCaptionLbl": Label 'Montant Déduit';
    //     Montant_NetCaptionLbl: Label 'Montant Net';
    //     Montant_BrutCaptionLbl: Label 'Montant Brut';
    //     GRecVendor : Record Vendor;

    // // [Scope('Internal')]
    // procedure GetTauxRetenu(var Compte: Code[20]) Taux: Decimal
    // begin
    //     IF "Gpe.Retenu.Source".FIND('-') THEN
    //         REPEAT
    //             IF "Gpe.Retenu.Source"."Compte Retenue" = Compte THEN
    //                 EXIT("Gpe.Retenu.Source"."% Retenue");
    //         UNTIL "Gpe.Retenu.Source".NEXT = 0;
    // end;

    // // [Scope('Internal')]
    // procedure GetAnnexe(var Compte: Code[20]) Annexe: Integer
    // begin
    //     IF "Gpe.Retenu.Source".FIND('-') THEN
    //         REPEAT
    //             IF "Gpe.Retenu.Source"."Compte Retenue" = Compte THEN
    //                 CASE FORMAT("Gpe.Retenu.Source".Annexe) OF
    //                     '':
    //                         EXIT(0);
    //                     'Annexe II':
    //                         EXIT(1);
    //                     'Annexe III':
    //                         EXIT(2);
    //                     'Annexe VI':
    //                         EXIT(3);
    //                     'Annexe V':
    //                         EXIT(4);
    //                     'Annexe IV':
    //                         EXIT(5);
    //                 END;
    //         UNTIL "Gpe.Retenu.Source".NEXT = 0;
    // end;
}

