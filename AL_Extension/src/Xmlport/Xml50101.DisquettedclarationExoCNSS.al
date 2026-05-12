//HS
xmlport 50101 "Disquette déclaration Exo CNSS"
{

    // ///ID Nav 39001401
    // DefaultFieldsValidation = false;
    // Direction = Export;
    // Format = FixedText;
    // schema
    // {
    //     textelement(NodeName1)
    //     {
    //         tableelement(Employee; Employee)
    //         {
    //             SourceTableView = SORTING("Social Security No.") ORDER(Ascending) WHERE("Exclu De Dec Trim CNSS" = CONST(true));
    //             RequestFilterFields = "No.";
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             // MinOccurs = Zero;

    //             textattribute(NumSociete)
    //             {
    //                 Width = 10;
    //             }
    //             textattribute(CodeExploitation)
    //             {
    //                 Width = 4;
    //             }
    //             textattribute(Trim)
    //             {
    //                 Width = 1;
    //             }
    //             textattribute(AnnéeM)
    //             {
    //                 Width = 4;
    //             }
    //             textattribute(PageN)
    //             {
    //                 Width = 3;
    //             }

    //             textattribute(Lig)
    //             {
    //                 Width = 2;
    //             }
    //             textattribute(NumsecSal)
    //             {
    //                 Width = 10;
    //             }
    //             textattribute(NomP)
    //             {
    //                 Width = 60;
    //             }
    //             textattribute(CINEmpl)
    //             {
    //                 Width = 8;
    //             }
    //             textattribute(MntFinal)
    //             {
    //                 Width = 10;
    //             }
    //             textattribute(CodeVide)
    //             {
    //                 Width = 10;
    //             }

    //             trigger OnAfterGetRecord()
    //             begin


    //                 NumSociete := '';
    //                 NumsecSal := '';
    //                 //Trim:='';
    //                 AnnéeM := '';
    //                 Montantcum := '';
    //                 nummat := '';
    //                 NomP := '';
    //                 PageN := '';
    //                 Lig := '';
    //                 Filler := '0000';
    //                 codcnss := '00';
    //                 // RB 13/04/2015
    //                 CodeExploitation := '0000';
    //                 CodeVide := '0000000000';
    //                 BEGIN
    //                     Total := 0;
    //                     LigneSalaireEnreg.RESET;
    //                     LigneSalaireEnreg.SETRANGE(Employee, Employee."No.");

    //                     LigneSalaireEnreg.SETFILTER("No.", PaieFrom."No." + '..' + PaieTo."No.");
    //                     IF LigneSalaireEnreg.FIND('-') THEN
    //                         REPEAT
    //                             Total := Total + LigneSalaireEnreg."Gross Salary"
    //                         UNTIL LigneSalaireEnreg.NEXT = 0;

    //                     IF (Total > 0)
    //                      THEN BEGIN

    //                         IF EmplContract.GET(Employee."Emplymt. Contract Code") THEN BEGIN
    //                             DefaultSoc.RESET;
    //                             DefaultSoc.SETRANGE("Employment Contract Code", EmplContract.Code);
    //                             DefaultSoc.SETRANGE("Social Contribution Code", TCNSS);
    //                             IF NOT DefaultSoc.FIND('-')
    //                               THEN BEGIN
    //                                 // MESSAGE('Employment Contract Code %1',TCNSS);
    //                                 //  MESSAGE('ERREUR');
    //                                 currXMLport.SKIP;
    //                             END;
    //                         END;
    //                         //             MESSAGE('OK');
    //                         NumSociete := DELCHR(infosoc."N° CNSS", '=', '/');
    //                         // RB LENGTH
    //                         NumSociete := PADSTR('', 10 - STRLEN(FORMAT(NumSociete)), '0') + FORMAT(NumSociete);
    //                         // RB LENGTH
    //                         IF Employee."Social Security No." = ''
    //                           THEN BEGIN
    //                             MESSAGE('Attention : Le fichier généré n''est pas valide !');
    //                             MESSAGE('Le salarié %1 n''a pas de N° affiliation sécurité sociale !', Employee."No." + ' - ' + Employee.FullName);
    //                             //NumsecSal := '          ';
    //                             NumsecSal := '0000000000';

    //                         END
    //                         ELSE
    //                             IF STRLEN(Employee."Social Security No.") > 10 THEN
    //                                 MESSAGE('Vérifiez le N° affiliation sécurité sociale du salarié %1', Employee."No." + ' - ' + Employee.FullName)
    //                             ELSE
    //                                 //MESSAGE ('Le salarié ',Employee."No." + ' - ' + Employee.FullName);
    //                                 NumsecSal := Employee."Social Security No.";
    //                         NumsecSal := PADSTR('', 10 - STRLEN(FORMAT(NumsecSal)), '0') + FORMAT(NumsecSal);
    //                         //      MESSAGE(FORMAT(Trimestre));
    //                         //Trim       := FORMAT(Trimestre+1);
    //                         AnnéeM := FORMAT(Année);
    //                         ;//COPYSTR(FORMAT(Année),1,4);
    //                         nummat := COPYSTR('1000000', 2, 6 - STRLEN(Employee."No.")) + Employee."No.";
    //                         NomP := Employee."First Name" + ' ' + Employee."Last Name";
    //                         CINEmpl := Employee."N° CIN";
    //                         CINEmpl := PADSTR('', 8 - STRLEN(FORMAT(CINEmpl)), '0') + FORMAT(CINEmpl);

    //                         //***********************************************************************************************************************
    //                         Total := ROUND(Total, 0.001);
    //                         Montantcum := FORMAT(Total * 1000 + 100000000);
    //                         NonNum := FORMAT('');
    //                         FOR k := 1 TO 10 DO BEGIN
    //                             IF ((Montantcum[k] <> '0') AND (Montantcum[k] <> '1') AND (Montantcum[k] <> '2') AND (Montantcum[k] <> '3') AND
    //                                 (Montantcum[k] <> '4') AND (Montantcum[k] <> '5') AND (Montantcum[k] <> '6') AND (Montantcum[k] <> '7') AND
    //                                 (Montantcum[k] <> '8') AND (Montantcum[k] <> '9')
    //                                ) THEN
    //                                 NonNum := FORMAT(Montantcum[k]);
    //                         END;
    //                         Montantcum := DELCHR(Montantcum, '=', NonNum);
    //                         MntFinal := '';
    //                         MntFinal := COPYSTR(Montantcum, 2, 10);
    //                         MntFinal := PADSTR('', 10 - STRLEN(FORMAT(MntFinal)), '0') + FORMAT(MntFinal);
    //                         //***********************************************************************************************************************



    //                         // N° ligne : 12 lignes / PAGEN
    //                         IF (i < 10) THEN Lig := '0' + FORMAT(i);

    //                         IF ((i MOD 12) + 1) < 10
    //                            THEN
    //                             Lig := '0' + FORMAT((i MOD 12) + 1)
    //                         ELSE
    //                             Lig := FORMAT((i MOD 12) + 1);

    //                         // N° PAGEN
    //                         IF ((i DIV 12) + 1) < 10
    //                           THEN
    //                             PageN := '00' + FORMAT((i DIV 12) + 1)
    //                         ELSE BEGIN
    //                             IF ((i DIV 12) + 1) < 100
    //                               THEN
    //                                 PageN := '0' + FORMAT((i DIV 12) + 1)
    //                             ELSE
    //                                 PageN := FORMAT((i DIV 12) + 1);
    //                         END;

    //                         i := i + 1;
    //                     END
    //                     ELSE
    //                         currXMLport.SKIP
    //                 END;
    //             end;
    //         }



    //     }
    // }

    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group("Veuillez présiser le trimestre dont vous voulez sortir la déclaration")
    //             {
    //                 field(PaieFrom; PaieFrom."No.")
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'De';

    //                     trigger OnDrillDown()
    //                     begin


    //                         CLEAR(F39001471);
    //                         IF F39001471.RUNMODAL = ACTION::LookupOK
    //                           THEN BEGIN
    //                             F39001471.GETRECORD(PaieFrom);
    //                             Année := PaieFrom.Year;
    //                             Trimestre := PaieFrom.Month MOD 2;
    //                         END;

    //                         RequestOptionsPage.UPDATE;
    //                     end;

    //                 }
    //                 field(Désignation; PaieFrom.Description)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Désignation';
    //                     Editable = false;

    //                 }
    //                 field(PaieTO; Paieto."No.")
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'A';
    //                     trigger OnDrillDown()
    //                     begin


    //                         CLEAR(F39001471);
    //                         IF F39001471.RUNMODAL = ACTION::LookupOK
    //                           THEN
    //                             F39001471.GETRECORD(PaieTo);

    //                         RequestOptionsPage.UPDATE;
    //                     end;
    //                 }
    //                 field(DésignationTo; PaieTo.Description)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Désignation';
    //                     Editable = false;

    //                 }
    //                 field("Année"; "Année")
    //                 {
    //                     ApplicationArea = all;
    //                 }
    //                 field(GCODECNSS; GCODECNSS)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Type CNSS';
    //                     TableRelation = "Social Contribution";
    //                 }
    //                 field(Trimestre; Trimestre)
    //                 {
    //                     ApplicationArea = all;
    //                     trigger OnValidate()
    //                     begin
    //                         Trim := FORMAT(Trimestre + 1);
    //                     end;
    //                 }

    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {


    //         }
    //     }
    // }
    // trigger OnPostXmlPort()
    // begin
    //     //  COMMIT;
    // end;

    // trigger OnInitXmlPort()
    // begin

    //     //CurrDataport.FILENAME := 'C:\DS%1.%2%3';
    //     i := 0;
    //     infosoc.GET;
    // end;

    // trigger OnPreXmlPort()
    // begin


    //     Trim := FORMAT(Trimestre + 1);
    //     AnnéeM := COPYSTR(FORMAT(Année), 3, 2);
    //     CNSSEmpl := COPYSTR(infosoc."N° CNSS", 1, 6);
    //     currXMLport.FILENAME := STRSUBSTNO('D:\DS%1.%2%3', CNSSEmpl, Trim, AnnéeM);
    //     /*IF TypeCNSS = 0 THEN BEGIN
    //                 TCNSS := GCODECNSS;
    //                 codcnss := '00';
    //             END
    //             ELSE
    //                 IF TypeCNSS = 1 THEN BEGIN
    //                     TCNSS := 'CNSS5';
    //                     codcnss := '11';
    //                 END
    //                 ELSE BEGIN
    //                     TCNSS := 'CNSS7';
    //                     codcnss := '11';
    //                 END
    //      */
    //     IF GCODECNSS <> '' THEN
    //         TCNSS := GCODECNSS;
    // end;

    // var
    //     codcnss: Code[2];
    //     // NumSociete: Text[10];
    //     // NumsecSal: Text[10];
    //     // Trim: Text[1];
    //     // AnnéeM: Text[4];
    //     Montantcum: Code[11];
    //     // MntFinal: Code[10];
    //     nummat: Text[6];
    //     // NomP: Text[34];
    //     // PageN: Text[3];
    //     // Lig: Text[2];

    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     OpPaieto: Option Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;

    //     OpPaieFrom: Option Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
    //     LigneSalaireEnreg: Record "Rec. Salary Lines";
    //     LigneSalaireEnreg1: Record "Rec. Salary Lines";
    //     LigneSalaireEnreg2: Record "Rec. Salary Lines";
    //     LigneSalaireEnreg3: Record "Rec. Salary Lines";

    //     Trimestre: Option "1er trimetre","2ème trimestre","3ème trimestre","4ème trimestre";
    //     Année: Integer;

    //     Total: Decimal;
    //     Comp: Text[30];

    //     CNSS: Record "Rec. Social Contributions";
    //     Total2: Decimal;
    //     Total3: Decimal;

    //     i: Integer;
    //     j: Integer;
    //     k: Integer;

    //     infosoc: Record "Company Information";
    //     CNSSEmpl: Code[8];

    //     EmplContract: Record "Employment Contract";
    //     DefaultSoc: Record "Default Soc. Contribution";

    //     PaieFrom: Record "Rec. Salary Headers";
    //     PaieTo: Record "Rec. Salary Headers";

    //     F39001471: Page "Recorded Payment List";

    //     NonNum: Text[1];

    //     TypeCNSS: Option CNSS,CNSS5,CNSS7;
    //     TCNSS: Code[10];
    //     Filler: Code[4];
    //     GCODECNSS: Code[10];

    //     "// RB SOROU 13/04/2015": Integer;

    //     // CodeExploitation: Code[4];
    //     // CINEmpl: Code[8];
    //     // CodeVide: Code[10];

    //     MoisDebut: Record "Rec. Salary Lines";
    //     MoisFin: Record "Rec. Salary Lines";

}