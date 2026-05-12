Codeunit 52048881 "RH-Doc. attachés"
{
    //GL2024  ID dans Nav 2009 : "39001412"
    trigger OnRun()
    begin
    end;

    var
        //GL2024 Automation non compatible   ComDia: OCX;
        //GL2024 Automation non compatible   wdApp: Automation;
        //GL2024 Automation non compatible   wdDoc: Automation;
        //GL2024 Automation non compatible  wdRange: Automation;
        RecGParamRessHum: Record "Human Resources Setup";


    procedure FileDialog(var Filename: Text[250]; InitFolder: Text[200]; ShowSave: Boolean; "Order": Integer)
    var
        FilterArray: array[20] of Text[80];
        i: Integer;
    begin
        RecGParamRessHum.Get();

        for i := 1 to 19 do
            FilterArray[i] := GetLanguageText(i);

        if (Order > 1) and (Order <= 19) then begin
            FilterArray[20] := FilterArray[1];
            FilterArray[1] := FilterArray[Order];
            FilterArray[Order] := FilterArray[20];
        end;

        /*  //GL2024 Automation non compatible  ComDia.DialogTitle := 'Navision - Documents attachés';
           ComDia.Filter := (
             FilterArray[1] + '|' +
             FilterArray[2] + '|' +
             FilterArray[3] + '|' +
             FilterArray[4] + '|' +
             FilterArray[5] + '|' +
             FilterArray[6] + '|' +
             FilterArray[19]);

           ComDia.Flags(4);
           ComDia.FilterIndex := 1;
           ComDia.InitDir(InitFolder);
           ComDia.FileName := Filename;

           if ShowSave then
               ComDia.ShowSave
           else
               ComDia.ShowOpen;

           if ComDia.FileName <> '' then begin
               Filename := ComDia.FileName;
               InitFolder := ComDia.InitDir;
           end;*/
    end;


    procedure GetLanguageText(TextNo: Integer): Text[250]
    begin
        case TextNo of

            1:
                exit('Document Word (*.doc)|*.doc');
            2:
                exit('Document Acrobat (*.pdf)|*.pdf');
            3:
                exit('Document Word (*.rtf)|*.rtf');

            20:
                exit('Le modèle pour %1 %2 est introuvable.');
            21:
                exit('Enregistrez le document.');
            22:
                exit('Veuillez choisir un nom pour le document Word.');
            23:
                exit('Le fichier %1 existe déjà. Voulez-vous remplacer le document existant ?');
            24:
                exit('Le fichier %1 n''existe pas. Vérifier le nom et le chemin d''accès.');
            25:
                exit('Ce modèle doit avoir au moins 8 champs de fusion. Veuillez vérifier %1.');
            26:
                exit('Le nombre de champs de fusion est différent de celui du modèle.');
            27:
                exit('Le fichier %1 existe déjà.\' +
                     'Voulez-vous vraiment remplacer le document existant par un document vierge ?');

            40:
                exit('%1 %2 ne peut être utilisé qu''avec des lignes de texte.');

            // Formats
            100:
                exit('<Sign><Integer Thousand><Decimals,3>'); // Std. Decimal format
            101:
                exit('<Day,2><Filler Character, >. <Month Text> <Year4>'); // Std. 7

        end;
    end;
}

