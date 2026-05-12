xmlport 50111 "Etat Mensuel Paie2"
{ //GL2024  ID dans Nav 2009 : "39001405"
    Direction = Import;
    Format = VariableText;
    Caption = 'Etat Mensuel Paie';
    UseRequestPage = false;
    TableSeparator = '<NewLine><NewLine>';
    FieldSeparator = ';';

    schema
    {
        textelement(Root)
        {
            tableelement(EtatMensuellePaie; "Etat Mensuelle Paie")   // Table 39001439
            {
                AutoSave = false;
                AutoUpdate = false;
                textelement(Mat) { }
                textelement(Heure15) { }
                textelement(Heure35) { }
                textelement(Heure50) { }
                textelement(Heure60) { }
                textelement(Heure120) { }
                textelement(HeureNormale) { }

                trigger OnBeforeInsertRecord()
                var
                    Emp: Record Employee;   // Table 5200

                    MatTxt: Code[10];
                    Heure15Txt: Decimal;
                    Heure35Txt: Decimal;
                    Heure50Txt: Decimal;
                    Heure60Txt: Decimal;
                    Heure120Txt: Decimal;
                    HeureNormaleTxt: Decimal;
                begin

                    Evaluate(MatTxt, Mat);
                    Evaluate(HeureNormaleTxt, HeureNormale);
                    Evaluate(Heure15Txt, Heure15);
                    Evaluate(Heure35Txt, Heure35);
                    Evaluate(Heure50Txt, Heure50);
                    Evaluate(Heure60Txt, Heure60);
                    Evaluate(Heure120Txt, Heure120);

                    //EtatMensuellePaie.INIT;
                    Emp.RESET;
                    EtatMensuellePaie.Matricule := Mat;
                    EtatMensuellePaie.VALIDATE("Heures Normal", HeureNormaleTxt);
                    //EtatMensuellePaie."Nombre Jour Prime Panier":=HeureNormale;
                    EtatMensuellePaie.VALIDATE("Nombre de jour", HeureNormaleTxt);
                    EtatMensuellePaie.VALIDATE("Heure 15", Heure15Txt);
                    EtatMensuellePaie.VALIDATE("Heure 35", Heure35Txt);
                    EtatMensuellePaie.VALIDATE("Heure 50", Heure50Txt);
                    EtatMensuellePaie.VALIDATE("Heure 60", Heure60Txt);
                    EtatMensuellePaie.VALIDATE("Heure 120", Heure120Txt);
                    IF Emp.GET(Mat) THEN EtatMensuellePaie.Nom := Emp."First Name" + ' ' + Emp."Last Name";
                    EtatMensuellePaie."Tot Heurs" := (HeureNormaleTxt + Heure15Txt + Heure50Txt + Heure35Txt + Heure60Txt + Heure120Txt);
                    EtatMensuellePaie.Disponible := TRUE;
                    EtatMensuellePaie.MODIFY;
                    //IF Mat<>'' THEN IF NOT EtatMensuellePaie.INSERT THEN EtatMensuellePaie.MODIFY;

                end;






            }

        }
    }

    var
    // MatTxt: Code[10];
    // Heure15Txt: Decimal;
    // Heure35Txt: Decimal;
    // Heure50Txt: Decimal;
    // Heure60Txt: Decimal;
    // Heure120Txt: Decimal;
    // HeureNormaleTxt: Decimal;
}
