page 52048982 "Entete Pointage Journalier"
{ //GL2024  ID dans Nav 2009 : "39001509"
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = card;
    SourceTable = "Entete Pointage Salarié Chanti";
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Entete Pointage Journalier';
    layout
    {
        area(content)
        {
            group(Choix)
            {
                Caption = 'Choix';
                field(LAffecatation; LAffecatation)
                {
                    ApplicationArea = all;
                    Caption = 'Affectation';
                    TableRelation = "Tranche STC";

                    trigger OnValidate()
                    begin
                        // Section.SETRANGE(Section, LAffecatation);
                        // IF Section.FINDFIRST THEN IF Section.Chantier = '' THEN ERROR(Text006);
                    end;
                }
                field(MoisAttach; MoisAttach)
                {
                    ApplicationArea = all;
                    Caption = 'Mois';
                }
                field(AnneeAttach; AnneeAttach)
                {
                    ApplicationArea = all;
                    Caption = 'Année';
                    Editable = true;
                }
            }
            part("Ligne Pointage Journalier"; "Ligne Pointage Journalier")
            {
                ApplicationArea = all;

                SubPageLink = Affectation = FIELD(Affecation), "Annee Attachement" = FIELD(Annee), "Mois Attachement" = FIELD("Mois Attachement");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Validation)
            {
                ApplicationArea = all;
                Caption = 'Validation';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF LAffecatation = '' THEN ERROR(Text004);
                    IF MoisAttach = 0 THEN ERROR(Text004);
                    IF NOT CONFIRM(Text001) THEN EXIT;

                    LignePointageJournalier.RESET;
                    LignePointageJournalier.SETRANGE("Annee Attachement", AnneeAttach);
                    LignePointageJournalier.SETRANGE("Mois Attachement", MoisAttach);
                    LignePointageJournalier.SETRANGE(Affectation, LAffecatation);
                    IF LignePointageJournalier.FINDFIRST THEN
                        REPEAT
                            if LignePointageJournalier."Montant HSup 15%" + LignePointageJournalier."Montant HSup 60%" <> 0 THEN BEGIN
                                BonReglement."Date Reglement" := DMY2DATE(1, LignePointageJournalier."Mois Attachement",
                                                                        LignePointageJournalier."Annee Attachement");

                                BonReglement."N° Bon" := FORMAT(LignePointageJournalier."Annee Attachement") + '-' +
                                                     FORMAT(LignePointageJournalier."Mois Attachement") + '-' + LignePointageJournalier.Matricule;
                                BonReglement.Annee := LignePointageJournalier."Annee Attachement";
                                BonReglement.Mois := LignePointageJournalier."Mois Attachement";
                                BonReglement.VALIDATE(Matricule, LignePointageJournalier.Matricule);
                                BonReglement."Type Salaire" := BonReglement."Type Salaire"::"Heure Supp";
                                BonReglement.Nombre := 1;
                                BonReglement.Montant := LignePointageJournalier."Montant HSup 15%" + LignePointageJournalier."Montant HSup 60%";
                                IF NOT BonReglement.INSERT THEN BonReglement.MODIFY;
                            END;
                        UNTIL LignePointageJournalier.NEXT = 0;

                    LignePointageJournalier.RESET;
                    LignePointageJournalier.SETRANGE("Annee Attachement", AnneeAttach);
                    LignePointageJournalier.SETRANGE("Mois Attachement", MoisAttach);
                    LignePointageJournalier.SETRANGE(Affectation, LAffecatation);
                    LignePointageJournalier.MODIFYALL(Statut, LignePointageJournalier.Statut::Valider);

                    IF EntetePointageJournalier.GET(LAffecatation, AnneeAttach, MoisAttach) THEN BEGIN
                        EntetePointageJournalier.Statut := EntetePointageJournalier.Statut::Valider;
                        EntetePointageJournalier.MODIFY;
                    END;

                    CurrPage.UPDATE;
                    MESSAGE(Text002);
                end;

            }
            action(Rafraichir)
            {
                ApplicationArea = all;
                Caption = 'Rafraichir';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF LAffecatation = '' THEN ERROR(Text004);
                    IF MoisAttach = 0 THEN ERROR(Text004);
                    CLEAR(EtatMensuellePaie);
                    rec.RESET;
                    IF AnneeAttach = 0 THEN AnneeAttach := DATE2DMY(WORKDATE, 3);
                    //GL3900 
                    /* PointageJournalierValidé2.SETRANGE("Annee Attachement", AnneeAttach);
                     PointageJournalierValidé2.SETRANGE("Mois Attachement", MoisAttach);
                     PointageJournalierValidé2.SETRANGE(Affectation, LAffecatation);
                     IF PointageJournalierValidé2.FINDFIRST THEN ERROR(Text003);*/

                    //TESTFIELD(Affecation);
                    RecGEmp.SETRANGE(Blocked, FALSE);
                    //RecGEmp.SETRANGE(Expatrie,FALSE);
                    RecGEmp.SETRANGE(Service, LAffecatation);
                    IF RecGEmp.FINDFIRST THEN
                        REPEAT
                            // Verifie Si Employe Attache A Une Autre Affecation
                            LignePointageJournalier.RESET;
                            LignePointageJournalier.SETRANGE("Annee Attachement", AnneeAttach);
                            LignePointageJournalier.SETRANGE("Mois Attachement", MoisAttach);
                            LignePointageJournalier.SETRANGE(Matricule, RecGEmp."No.");
                            LignePointageJournalier.SETFILTER(Affectation, '<>%1', LAffecatation);
                            IF LignePointageJournalier.FINDFIRST THEN
                                REPEAT
                                    LignePointageJournalier.DELETE;
                                UNTIL LignePointageJournalier.NEXT = 0;
                            // ERROR(Text005,RecGEmp."No.",LignePointageJournalier.Affectation);
                            // Verifie Si Employe Attache A Une Autre Affecation
                            Dimanche := 0;
                            EtatMensuellePaie.INIT;
                            EtatMensuellePaie.Matricule := RecGEmp."No.";
                            EtatMensuellePaie.Nom := RecGEmp."First Name";
                            EtatMensuellePaie."Presence Perso" := 0;
                            // EtatMensuellePaie."Nombre de jour" := 0;
                            EtatMensuellePaie."Heures Normal" := 0;
                            EtatMensuellePaie."Type Salarié" := 1;
                            EtatMensuellePaie.Journee := rec.Journee;
                            EtatMensuellePaie.Affectation := LAffecatation;
                            // EtatMensuellePaie.Chantier := RecGEmp.Chantier;
                            // EtatMensuellePaie.Qualification := RecGEmp.Qualification;
                            EtatMensuellePaie."Semaine Attachement" := rec.Semaine;
                            EtatMensuellePaie."Annee Attachement" := AnneeAttach;
                            EtatMensuellePaie."Mois Attachement" := MoisAttach;
                            DateAttach := DMY2DATE(1, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."1" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(2, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."2" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(3, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."3" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(4, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."4" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(5, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."5" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(6, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."6" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(7, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."7" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(8, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."8" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(9, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."9" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(10, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."10" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(11, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."11" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(12, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."12" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(13, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."13" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(14, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."14" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(15, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."15" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(16, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."16" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(17, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."17" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(18, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."18" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(19, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."19" := 1
                            ELSE
                                Dimanche += 1;
                            DateAttach := DMY2DATE(20, MoisAttach, AnneeAttach);
                            IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                EtatMensuellePaie."20" := 1
                            ELSE
                                Dimanche += 1;
                            /*   DateAttach := DMY2DATE(21, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."21" := 1
                               ELSE
                                   Dimanche += 1;
                               DateAttach := DMY2DATE(22, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."22" := 1
                               ELSE
                                   Dimanche += 1;
                               DateAttach := DMY2DATE(23, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."23" := 1
                               ELSE
                                   Dimanche += 1;
                               DateAttach := DMY2DATE(24, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."24" := 1
                               ELSE
                                   Dimanche += 1;
                               DateAttach := DMY2DATE(25, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."25" := 1
                               ELSE
                                   Dimanche += 1;

                               DateAttach := DMY2DATE(26, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."26" := 1
                               ELSE
                                   Dimanche += 1;

                               DateAttach := DMY2DATE(27, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."27" := 1
                               ELSE
                                   Dimanche += 1;

                               DateAttach := DMY2DATE(28, MoisAttach, AnneeAttach);
                               IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                   EtatMensuellePaie."28" := 1
                               ELSE
                                   Dimanche += 1;

                               FinMois := CALCDATE('FM', DMY2DATE(1, MoisAttach, AnneeAttach));
                               JourFinMois := DATE2DMY(FinMois, 1);
                               IF JourFinMois >= 29 THEN BEGIN
                                   DateAttach := DMY2DATE(29, MoisAttach, AnneeAttach);
                                   IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                       EtatMensuellePaie."29" := 1
                                   ELSE
                                       Dimanche += 1;
                               END;
                               IF JourFinMois >= 30 THEN BEGIN
                                   DateAttach := DMY2DATE(30, MoisAttach, AnneeAttach);
                                   IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                       EtatMensuellePaie."30" := 1
                                   ELSE
                                       Dimanche += 1;
                               END;
                               IF JourFinMois = 31 THEN BEGIN
                                   DateAttach := DMY2DATE(31, MoisAttach, AnneeAttach);
                                   IF DATE2DWY(DateAttach, 1) <> 7 THEN
                                       EtatMensuellePaie."31" := 1
                                   ELSE
                                       Dimanche += 1;
                               END;
                               IF RecGEmp.Horaire THEN BEGIN
                                   IF EtatMensuellePaie."1" = 1 THEN EtatMensuellePaie."1" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."2" = 1 THEN EtatMensuellePaie."2" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."3" = 1 THEN EtatMensuellePaie."3" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."4" = 1 THEN EtatMensuellePaie."4" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."5" = 1 THEN EtatMensuellePaie."5" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."6" = 1 THEN EtatMensuellePaie."6" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."7" = 1 THEN EtatMensuellePaie."7" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."8" = 1 THEN EtatMensuellePaie."8" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."9" = 1 THEN EtatMensuellePaie."9" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."10" = 1 THEN EtatMensuellePaie."10" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."11" = 1 THEN EtatMensuellePaie."11" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."12" = 1 THEN EtatMensuellePaie."12" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."13" = 1 THEN EtatMensuellePaie."13" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."14" = 1 THEN EtatMensuellePaie."14" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."15" = 1 THEN EtatMensuellePaie."15" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."16" = 1 THEN EtatMensuellePaie."16" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."17" = 1 THEN EtatMensuellePaie."17" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."18" = 1 THEN EtatMensuellePaie."18" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."19" = 1 THEN EtatMensuellePaie."19" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."20" = 1 THEN EtatMensuellePaie."20" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."21" = 1 THEN EtatMensuellePaie."21" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."22" = 1 THEN EtatMensuellePaie."22" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."23" = 1 THEN EtatMensuellePaie."23" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."24" = 1 THEN EtatMensuellePaie."24" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."25" = 1 THEN EtatMensuellePaie."25" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."26" = 1 THEN EtatMensuellePaie."26" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."27" = 1 THEN EtatMensuellePaie."27" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."28" = 1 THEN EtatMensuellePaie."28" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."29" = 1 THEN EtatMensuellePaie."29" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."30" = 1 THEN EtatMensuellePaie."30" := RecGEmp."Heure / Jour";
                                   IF EtatMensuellePaie."31" = 1 THEN EtatMensuellePaie."31" := RecGEmp."Heure / Jour";
                               END;
                               EtatMensuellePaie."1" := 0;
                               EtatMensuellePaie."2" := 0;
                               EtatMensuellePaie."3" := 0;
                               EtatMensuellePaie."4" := 0;
                               EtatMensuellePaie."5" := 0;
                               EtatMensuellePaie."6" := 0;
                               EtatMensuellePaie."7" := 0;
                               EtatMensuellePaie."8" := 0;
                               EtatMensuellePaie."9" := 0;
                               EtatMensuellePaie."10" := 0;
                               EtatMensuellePaie."11" := 0;
                               EtatMensuellePaie."12" := 0;
                               EtatMensuellePaie."13" := 0;
                               EtatMensuellePaie."14" := 0;
                               EtatMensuellePaie."15" := 0;
                               EtatMensuellePaie."16" := 0;
                               EtatMensuellePaie."17" := 0;
                               EtatMensuellePaie."18" := 0;
                               EtatMensuellePaie."19" := 0;
                               EtatMensuellePaie."20" := 0;
                               EtatMensuellePaie."21" := 0;
                               EtatMensuellePaie."22" := 0;
                               EtatMensuellePaie."23" := 0;
                               EtatMensuellePaie."24" := 0;
                               EtatMensuellePaie."25" := 0;
                               EtatMensuellePaie."26" := 0;
                               EtatMensuellePaie."27" := 0;
                               EtatMensuellePaie."28" := 0;
                               EtatMensuellePaie."29" := 0;
                               EtatMensuellePaie."30" := 0;
                               EtatMensuellePaie."31" := 0;

                               EtatMensuellePaie.Présence := Presence;
                               IF RecGEmp.Horaire THEN
                                   EtatMensuellePaie."Total Heures" := EtatMensuellePaie."1" + EtatMensuellePaie."2" + EtatMensuellePaie."3" +
                                   EtatMensuellePaie."4" + EtatMensuellePaie."5" + EtatMensuellePaie."6" + EtatMensuellePaie."7" +
                                   EtatMensuellePaie."8" + EtatMensuellePaie."9" + EtatMensuellePaie."10" +
                                   EtatMensuellePaie."11" + EtatMensuellePaie."12" + EtatMensuellePaie."13" + EtatMensuellePaie."14" +
                                   EtatMensuellePaie."15" + EtatMensuellePaie."16" + EtatMensuellePaie."17" + EtatMensuellePaie."18" + EtatMensuellePaie."19" +
                                   EtatMensuellePaie."20" + EtatMensuellePaie."21" + EtatMensuellePaie."22" +
                                   EtatMensuellePaie."23" + EtatMensuellePaie."24" + EtatMensuellePaie."25" + EtatMensuellePaie."26" +
                                   EtatMensuellePaie."27" + EtatMensuellePaie."28" + EtatMensuellePaie."29" + EtatMensuellePaie."30" + EtatMensuellePaie."31";
                               IF RecGEmp."En Deplacement" THEN BEGIN
                                   IF EtatMensuellePaie.Présence <= 26 THEN
                                       EtatMensuellePaie.Deplacement := EtatMensuellePaie.Présence
                                   ELSE
                                       EtatMensuellePaie.Deplacement := 26;
                               END;
                               EtatMensuellePaie."Heure Mauvais Temps" := GetAncienSoldeHMVT(AnneeAttach, MoisAttach, RecGEmp."No.");
                               EtatMensuellePaie."Base Jour" := EtatMensuellePaie.Présence;*/
                            IF EtatMensuellePaie.INSERT THEN;
                        UNTIL RecGEmp.NEXT = 0;
                    rec.SETRANGE(Annee, AnneeAttach);
                    rec.SETRANGE("Mois Attachement", MoisAttach);
                    rec.SETRANGE(Affecation, LAffecatation);

                    CurrPage.UPDATE;
                end;





            }



        }

    }

    trigger OnAfterGetRecord()
    begin
        Heure := 120000T;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrPage.EDITABLE(TRUE);
    end;

    trigger OnOpenPage()
    begin
        rec.SETRANGE(Annee, 2000);
    end;

    var
        Text001: Label 'Valider Cette Attachement';
        EtatMensuellePaie: Record "Ligne Pointage Salarié Chanti";
        EntetePointageJournalier: Record "Entete Pointage Salarié Chanti";
        EntetePointageJournalier2: Record "Entete Pointage Salarié Chanti";
        BonReglement: record "Bon Reglement";
        RecGEmp: Record Employee;
        i: Integer;
        d: Dialog;
        //GL3900    MgmtSuppHour: Codeunit "Management of Work Hours";
        ToTNbrjours: Decimal;
        ToTNbrHeures: Decimal;
        CodeQualification: Code[20];
        CodeAffectation: Code[20];
        "NombreSalarié": Integer;
        Heure: Time;
        //GL3900   "PointageJournalierValidé": Record "Ligne Pointage Journ. Validé";
        //GL3900   "PointageJournalierValidé2": Record "Ligne Pointage Journ. Validé";
        LignePointageJournalier: Record "Ligne Pointage Salarié Chanti";
        Text002: Label 'Validation Effectuée Avec Succée';
        Text003: Label 'Journee Deja Validé';
        //GL3900  "EntetePointageJournValidé": Record "Entete Pointage Journ. Validé";
        LAffecatation: Code[20];
        MoisAttach: Option " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        AnneeAttach: Integer;
        Text004: Label 'Remplir Tous Les Champs';
        DateAttach: Date;
        FinMois: Date;
        k: Integer;
        Dimanche: Integer;
        DateDebut: Date;
        DateFin: Date;
        Text005: Label 'Le Salarié %1 Est Attaché A L''Affectaion  %2 Pour Cette Année et Ce Mois';
        JourFinMois: Integer;
        Section: Record "Tranche STC";
        Text006: Label 'Chantier Doit Etre Mentionner Pour Cette Affectation';


    procedure Presence() JoursPres: Integer
    begin
        JoursPres := 0;
        IF EtatMensuellePaie."1" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."2" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."3" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."4" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."5" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."6" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."7" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."8" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."9" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."10" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."11" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."12" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."13" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."14" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."15" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."16" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."17" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."18" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."19" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."20" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."21" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."22" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."23" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."24" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."25" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."26" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."27" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."28" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."29" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."30" <> 0 THEN JoursPres += 1;
        IF EtatMensuellePaie."31" <> 0 THEN JoursPres += 1;
        EXIT(JoursPres);
    end;


    procedure GetAncienSoldeHMVT(ParaAnnee: Integer; ParaMois: Integer; "ParaSalarié": Code[20]) SoldeHMVT: Decimal
    var
        "LignePointageSalariéChanti": Record "Ligne Pointage Salarié Chanti";
    begin

        LignePointageSalariéChanti.RESET;
        IF ParaMois <> 1 THEN BEGIN
            LignePointageSalariéChanti.SETRANGE("Annee Attachement", ParaAnnee);
            LignePointageSalariéChanti.SETRANGE("Mois Attachement", ParaMois - 1);
        END
        ELSE BEGIN
            LignePointageSalariéChanti.SETRANGE("Annee Attachement", ParaAnnee - 1);
            LignePointageSalariéChanti.SETRANGE("Mois Attachement", 12);
        END;
        LignePointageSalariéChanti.SETRANGE(Matricule, ParaSalarié);
        //  IF LignePointageSalariéChanti.FINDFIRST THEN EXIT(LignePointageSalariéChanti."Solde Heure Mauvais Temps");
    end;
}

