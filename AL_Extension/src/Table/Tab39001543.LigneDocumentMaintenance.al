// table 39001543 "Ligne Document Maintenance"
// {
//     //GL2024  ID dans Nav 2009 : "39001543"
//     fields
//     {
//         field(1; "N° Documents"; Code[20])
//         {
//         }
//         field(2; Materiel; Code[20])
//         {
//             TableRelation = Véhicule."N° Vehicule";

//             trigger OnValidate()
//             begin
//                 RecVéhicule.RESET();
//                 RecVéhicule.SETRANGE("N° Vehicule", Materiel);
//                 IF RecVéhicule.FINDFIRST() THEN BEGIN
//                     Designation := RecVéhicule.Désignation;
//                     Immatriculation := RecVéhicule.Immatriculation;
//                 END;


//                 RecLigneDocumentMaintenance.RESET();
//                 RecLigneDocumentMaintenance.SETRANGE("N° Documents", "N° Documents");
//                 RecLigneDocumentMaintenance.SETRANGE(Materiel, Materiel);
//                 IF RecLigneDocumentMaintenance.FINDLAST THEN BEGIN
//                     "N° Ligne" := RecLigneDocumentMaintenance."N° Ligne" + 1;
//                 END
//                 ELSE
//                     "N° Ligne" := 1;
//             end;
//         }
//         field(3; Designation; Text[150])
//         {
//         }
//         field(4; Immatriculation; Text[50])
//         {
//         }
//         field(5; "11"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(6; "12"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(7; "13"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(8; "21"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(9; "22"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(10; "23"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(11; "31"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(12; "32"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(13; "33"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(14; "41"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(15; "42"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(16; "43"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(17; "51"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(18; "52"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(19; "53"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(20; "61"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(21; "62"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(22; "63"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(23; "71"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(24; "72"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(25; "73"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalculerLigne();
//             end;
//         }
//         field(26; "Temps Fonctionnement"; Decimal)
//         {
//         }
//         field(27; "Nbre Panne"; Integer)
//         {
//         }
//         field(28; "Temps Maintenance"; Decimal)
//         {
//         }
//         field(29; "Nbre Maintenance"; Integer)
//         {
//         }
//         field(30; MTTF; Decimal)
//         {
//         }
//         field(31; MTBF; Decimal)
//         {
//         }
//         field(32; MTTR; Decimal)
//         {
//         }
//         field(33; "Disponibilité"; Decimal)
//         {
//         }
//         field(34; "Report Temps Fonctionnement"; Decimal)
//         {
//         }
//         field(35; "N° Ligne"; Integer)
//         {
//         }
//         field(36; "Filtre Materiel"; Code[20])
//         {

//             trigger OnValidate()
//             begin
//                 RecDocumentMaintenance.RESET();
//                 RecDocumentMaintenance.SETRANGE("N° Document", "N° Documents");
//                 IF RecDocumentMaintenance.FINDFIRST THEN CodeChantier := RecDocumentMaintenance.Chantier;

//                 //RecVéhicule2.SETFILTER(Marche,'*'+UPPERCASE("Filtre Materiel")+'*');

//                 RecVéhicule2.SETFILTER(Marche, '*' + UPPERCASE(CodeChantier) + '*');
//             end;
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "N° Documents", Materiel, "N° Ligne", "Filtre Materiel")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnModify()
//     begin
//         /*CalculerTempsFonctionnel();
//         CalculerNbredePanne();
//         CalculerTempsMaintenance();
//         CalculerNbreMaintenance();*/

//     end;

//     var
//         "RecVéhicule": Record "Véhicule";
//         RecLigneDocumentMaintenance: Record "Ligne Document Maintenance";
//         RecLigneDocumentMaintenance2: Record "Ligne Document Maintenance";
//         RecLigneDocumentMaintenance3: Record "Ligne Document Maintenance";
//         TempsFonctionnement: Decimal;
//         "RecVéhicule2": Record "Véhicule";
//         CodeMateriel: Code[20];
//         RecDocumentMaintenance: Record "Document Maintenance";
//         CodeChantier: Code[20];


//     procedure CalculerTempsFonctionnel()
//     begin
//         TempsFonctionnement := 0;
//         IF "N° Ligne" = 1 THEN BEGIN
//             "Temps Fonctionnement" := "11" + "21" + "31" + "41" + "51" + "61" + "71";
//         END;

//         IF "N° Ligne" > 1 THEN BEGIN
//             TempsFonctionnement := "11" + "21" + "31" + "41" + "51" + "61" + "71";
//             RecLigneDocumentMaintenance3.RESET();
//             RecLigneDocumentMaintenance3.SETRANGE("N° Documents", "N° Documents");
//             RecLigneDocumentMaintenance3.SETRANGE(Materiel, Materiel);
//             RecLigneDocumentMaintenance3.SETRANGE("N° Ligne", 1);
//             IF RecLigneDocumentMaintenance3.FINDFIRST THEN BEGIN
//                 RecLigneDocumentMaintenance3."Temps Fonctionnement" :=
//                      RecLigneDocumentMaintenance3."Temps Fonctionnement" + TempsFonctionnement;
//                 RecLigneDocumentMaintenance3.MODIFY;
//             END;

//         END;
//     end;


//     procedure CalculerNbredePanne()
//     begin
//         "Nbre Panne" := 0;

//         IF "12" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//         IF "22" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//         IF "32" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//         IF "42" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//         IF "52" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//         IF "62" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//         IF "72" > 0 THEN "Nbre Panne" := "Nbre Panne" + 1;
//     end;


//     procedure CalculerTempsMaintenance()
//     begin
//         "Temps Maintenance" := "13" + "23" + "33" + "43" + "53" + "63" + "73";
//     end;


//     procedure CalculerNbreMaintenance()
//     begin
//         "Nbre Maintenance" := 0;

//         IF "13" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//         IF "23" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//         IF "33" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//         IF "43" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//         IF "53" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//         IF "63" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//         IF "73" > 0 THEN "Nbre Maintenance" := "Nbre Maintenance" + 1;
//     end;


//     procedure CalculerLigne()
//     begin
//         CalculerTempsFonctionnel();
//         CalculerNbredePanne();
//         CalculerTempsMaintenance();
//         CalculerNbreMaintenance();
//         IF "Nbre Panne" > 0 THEN MTBF := "Temps Fonctionnement" / "Nbre Panne";
//         IF "Nbre Maintenance" > 0 THEN MTTR := "Temps Maintenance" / "Nbre Maintenance";
//         IF "Nbre Panne" > 0 THEN CalculerMTTF();
//         IF (MTTF + MTTR) > 0 THEN Disponibilité := MTTF / (MTTF + MTTR);
//     end;


//     procedure CalculerMTTF()
//     begin
//         MTTF := 0;
//         IF "72" > 0 THEN BEGIN
//             MTTF := ("11" + "21" + "31" + "41" + "51" + "61" + "71") / "Nbre Panne";
//         END
//         ELSE
//             IF "62" > 0 THEN BEGIN
//                 MTTF := ("11" + "21" + "31" + "41" + "51" + "61") / "Nbre Panne";
//             END
//             ELSE
//                 IF "52" > 0 THEN BEGIN
//                     MTTF := ("11" + "21" + "31" + "41" + "51") / "Nbre Panne";
//                 END
//                 ELSE
//                     IF "42" > 0 THEN BEGIN
//                         MTTF := ("11" + "21" + "31" + "41") / "Nbre Panne";
//                     END
//                     ELSE
//                         IF "32" > 0 THEN BEGIN
//                             MTTF := ("11" + "21" + "31") / "Nbre Panne";
//                         END
//                         ELSE
//                             IF "22" > 0 THEN BEGIN
//                                 MTTF := ("11" + "21") / "Nbre Panne";
//                             END
//                             ELSE
//                                 IF "12" > 0 THEN BEGIN
//                                     MTTF := "11" / "Nbre Panne";
//                                 END;
//     end;
// }

