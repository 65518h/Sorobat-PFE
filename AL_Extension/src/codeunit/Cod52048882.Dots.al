Codeunit 52048882 Dots
{
    //GL2024  ID dans Nav 2009 : "39001413"
    trigger OnRun()
    begin
    end;

    var
        //GL2024 Automation non compatible      wdApp: Automation;
        //GL2024 Automation non compatible   wdDoc: Automation;
        //GL2024 Automation non compatible   wdRange: Automation;
        InfoSoc: Record "Company Information";
        ParamRessHum: Record "Human Resources Setup";
        ContratTravail: Record "Employment Contract";
        Responsable: Record Employee;


    procedure FileDialog(var Filename: Text[250]; InitFolder: Text[200]; ShowSave: Boolean; "Order": Integer)
    var
        FilterArray: array[20] of Text[80];
        i: Integer;
    begin
        /*
        ParamRessHum.GET();
        
        FOR i := 1 TO 19 DO
          FilterArray[i] := GetLanguageText(i);
        
        IF (Order > 1) AND (Order <= 19) THEN BEGIN
          FilterArray[20] := FilterArray[1];
          FilterArray[1] := FilterArray[Order];
          FilterArray[Order] := FilterArray[20];
        END;
        
        ComDia.DialogTitle := 'Navision - Modèles de documents standards';
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
        
        IF ShowSave THEN
          ComDia.ShowSave
        ELSE
          ComDia.ShowOpen;
        
        IF ComDia.FileName <> '' THEN BEGIN
          Filename := ComDia.FileName;
          InitFolder := ComDia.InitDir;
        END;
        */

    end;


    procedure GetLanguageText(TextNo: Integer): Text[250]
    begin
        case TextNo of

            1:
                exit('Modèles Word (*.dot)|*.dot');

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


    procedure AttestationDepuis(Slr: Record Employee)
    begin
        InfoSoc.Find;
        ParamRessHum.Find;
        /*
         //GL2024 Automation non compatible
                Create(wdApp);

                if ParamRessHum."Attestation de travail depuis" = '' then
                    Error('Erreur :\Modèle d''attestation de travail non mentionné.');

                wdDoc := wdApp.Documents.AddOld(ParamRessHum."Attestation de travail depuis");
                wdApp.ActiveDocument.Fields.Update;

                wdRange := wdApp.ActiveDocument.Fields.Item(1).Result;
                //GL2024  wdRange.Text := Format(Slr."Family Situation A");
                wdRange.Text := Format(Slr."Marital Status");

                wdRange.Bold := 0;

                wdRange := wdApp.ActiveDocument.Fields.Item(2).Result;
                wdRange.Text := Format(Slr."First Name" + ' ' + Slr."Last Name");
                wdRange.Bold := 0;

                if ((Slr.Gender = 1) and (Slr."Middle Name" <> '')) then begin
                    wdRange := wdApp.ActiveDocument.Fields.Item(3).Result;
                    wdRange.Text := 'née';
                    wdRange.Bold := 0;

                    wdRange := wdApp.ActiveDocument.Fields.Item(4).Result;
                    if Slr."Middle Name" <> '' then
                        wdRange.Text := Format(Slr."Middle Name")
                    else
                        wdRange.Text := Format(' - ');
                    wdRange.Bold := 0;
                end;

                wdRange := wdApp.ActiveDocument.Fields.Item(5).Result;
                wdRange.Text := Format(Slr."Job Title");
                wdRange.Bold := 0;

                wdRange := wdApp.ActiveDocument.Fields.Item(6).Result;
                wdRange.Text := Format(Slr."Employment Date");
                wdRange.Bold := 0;*/

        /*
        IF ContratTravail.GET (Slr."Emplymt. Contract Code") THEN
          BEGIN
            IF ContratTravail."Modèle contrat de travail" <> '' THEN
              BEGIN
                wdRange := wdApp.ActiveDocument.Fields.Item(7).Result;
                wdRange.Text := FORMAT('(' + ContratTravail.Code + ')  ' + ContratTravail.Désignation);
                wdRange.Bold := 0;
              END;
          END;
        */

        /*    //GL2024 Automation non compatible  wdRange := wdApp.ActiveDocument.Fields.Item(7).Result;
             wdRange.Text := Format(Slr."Relation de travail");
             wdRange.Bold := 0;

             wdRange := wdApp.ActiveDocument.Fields.Item(8).Result;
             wdRange.Text := Format(InfoSoc.City);
             wdRange.Bold := 0;

             wdRange := wdApp.ActiveDocument.Fields.Item(9).Result;
             wdRange.Text := Format(WorkDate);
             wdRange.Bold := 0;

             if ParamRessHum."Responsable personnel" <> '' then begin
                 if Responsable.Get(ParamRessHum."Responsable personnel") then begin
                     wdRange := wdApp.ActiveDocument.Fields.Item(10).Result;
                     wdRange.Text := Responsable."First Name" + ' ' + Responsable."Last Name";
                     wdRange.Bold := 0;

                     wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
                     wdRange.Text := Responsable."Job Title";
                     wdRange.Bold := 0;
                 end
                 else begin
                     wdRange := wdApp.ActiveDocument.Fields.Item(10).Result;
                     wdRange.Text := '# Responsable introuvable #';
                     wdRange.Bold := 0;

                     wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
                     wdRange.Text := '# Responsable introuvable #';
                     wdRange.Bold := 0;
                 end;
             end
             else begin
                 wdRange := wdApp.ActiveDocument.Fields.Item(10).Result;
                 wdRange.Text := '# Responsable non mentionné #';
                 wdRange.Bold := 0;

                 wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
                 wdRange.Text := '# Responsable non mentionné #';
                 wdRange.Bold := 0;
             end;

             wdApp.Visible := true;
             wdApp.ActiveDocument.Fields.Unlink;*/

    end;


    procedure AttestationPeriode(Slr: Record Employee)
    begin
        InfoSoc.Find;
        ParamRessHum.Find;

        /* //GL2024 Automation non compatible      Create(wdApp);

              if ParamRessHum."Attestation de travail depuis" = '' then
                  Error('Erreur :\Modèle d''attestation de travail non mentionné.');

              wdDoc := wdApp.Documents.AddOld(ParamRessHum."Attestation de travail période");
              wdApp.ActiveDocument.Fields.Update;

              wdRange := wdApp.ActiveDocument.Fields.Item(1).Result;
              //GL2024 wdRange.Text := Format(Slr."Family Situation A");
              wdRange.Text := Format(Slr."Marital Status");

              wdRange.Bold := 0;

              wdRange := wdApp.ActiveDocument.Fields.Item(2).Result;
              wdRange.Text := Format(Slr."First Name" + ' ' + Slr."Last Name");
              wdRange.Bold := 0;

              if ((Slr.Gender = 1) and (Slr."Middle Name" <> '')) then begin
                  wdRange := wdApp.ActiveDocument.Fields.Item(3).Result;
                  wdRange.Text := 'née';
                  wdRange.Bold := 0;

                  if Slr."Middle Name" <> '' then
                      wdRange.Text := Format(Slr."Middle Name")
                  else
                      wdRange.Text := Format(' - ');
              end;

              wdRange := wdApp.ActiveDocument.Fields.Item(5).Result;
              wdRange.Text := Format(Slr."Job Title");
              wdRange.Bold := 0;

              wdRange := wdApp.ActiveDocument.Fields.Item(6).Result;
              wdRange.Text := Format(Slr."Employment Date");
              wdRange.Bold := 0;

              wdRange := wdApp.ActiveDocument.Fields.Item(7).Result;
              wdRange.Text := Format(Slr."Termination Date");
              wdRange.Text := Format(0D);
              wdRange.Bold := 0;*/

        /*
        IF ContratTravail.GET (Slr."Emplymt. Contract Code") THEN
          BEGIN
            IF ContratTravail."Modèle contrat de travail" <> '' THEN
              BEGIN
                wdRange := wdApp.ActiveDocument.Fields.Item(8).Result;
                wdRange.Text := FORMAT('(' + ContratTravail.Code + ')  ' + ContratTravail.Désignation);
                wdRange.Bold := 0;
              END;
          END;
        */

        /* //GL2024 Automation non compatible  wdRange := wdApp.ActiveDocument.Fields.Item(8).Result;
          wdRange.Text := Format(Slr."Relation de travail");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(9).Result;
          wdRange.Text := Format(InfoSoc.City);
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(10).Result;
          wdRange.Text := Format(WorkDate);
          wdRange.Bold := 0;

          if ParamRessHum."Responsable personnel" <> '' then begin
              if Responsable.Get(ParamRessHum."Responsable personnel") then begin
                  wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
                  wdRange.Text := Responsable."First Name" + ' ' + Responsable."Last Name";
                  wdRange.Bold := 0;

                  wdRange := wdApp.ActiveDocument.Fields.Item(12).Result;
                  wdRange.Text := Responsable."Job Title";
                  wdRange.Bold := 0;
              end
              else begin
                  wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
                  wdRange.Text := '# Responsable introuvable #';
                  wdRange.Bold := 0;

                  wdRange := wdApp.ActiveDocument.Fields.Item(12).Result;
                  wdRange.Text := '# Responsable introuvable #';
                  wdRange.Bold := 0;
              end;
          end
          else begin
              wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
              wdRange.Text := '# Responsable non mentionné #';
              wdRange.Bold := 0;

              wdRange := wdApp.ActiveDocument.Fields.Item(12).Result;
              wdRange.Text := '# Responsable non mentionné #';
              wdRange.Bold := 0;
          end;

          wdApp.Visible := true;
          wdApp.ActiveDocument.Fields.Unlink;*/

    end;


    procedure CertifDeTravail(Slr: Record Employee)
    begin
        InfoSoc.Find;
        ParamRessHum.Find;

        /* //GL2024 Automation non compatible  Create(wdApp);

          if ParamRessHum."Attestation de travail depuis" = '' then
              Error('Erreur :\Modèle d''attestation de travail non mentionné.');

          wdDoc := wdApp.Documents.AddOld(ParamRessHum."Certif de travail");
          wdApp.ActiveDocument.Fields.Update;

          wdRange := wdApp.ActiveDocument.Fields.Item(1).Result;
          wdRange.Text := Format(InfoSoc.Name + ' ' + InfoSoc."Name 2");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(2).Result;
          wdRange.Text := Format(InfoSoc.Address + ' ' + InfoSoc."Address 2" + ' - ' + InfoSoc.City);
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(3).Result;
          //GL2024 wdRange.Text := Format(InfoSoc."N° CNSS Employeur");
          wdRange.Text := Format(InfoSoc."N° CNSS");
          wdRange.Bold := 0;


          wdRange := wdApp.ActiveDocument.Fields.Item(4).Result;
          //GL2024 wdRange.Text := Format(Slr."Family Situation A");
          wdRange.Text := Format(Slr."Marital Status");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(5).Result;
          wdRange.Text := Format(Slr."First Name" + ' ' + Slr."Last Name");
          wdRange.Bold := 0;


          if ((Slr.Gender = 1) and (Slr."Middle Name" <> '')) then begin
              wdRange := wdApp.ActiveDocument.Fields.Item(6).Result;
              if Slr."Middle Name" <> '' then
                  wdRange.Text := 'née ' + Format(Slr."Middle Name")
              else
                  wdRange.Text := Format(' - ');
              wdRange.Bold := 0;
          end;

          wdRange := wdApp.ActiveDocument.Fields.Item(7).Result;
          wdRange.Text := Format(Slr.Address + ' ' + Slr."Address 2" + ' - ' + Slr.City);
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(8).Result;
          wdRange.Text := Format(Slr."Social Security No.");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(9).Result;
          wdRange.Text := Format(Slr."National Identity Card No.");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(10).Result;
          wdRange.Text := Format(Slr."Job Title");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(11).Result;
          wdRange.Text := Format(Slr."Employment Date");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(12).Result;
          wdRange.Text := 'jusqu''au ' + Format(Slr."Termination Date");
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(13).Result;
          wdRange.Text := Format(InfoSoc.City);
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(14).Result;
          wdRange.Text := Format(WorkDate);
          wdRange.Bold := 0;

          wdRange := wdApp.ActiveDocument.Fields.Item(15).Result;
          wdRange.Text := Format(Slr."First Name" + ' ' + Slr."Last Name");
          wdRange.Bold := 0;

          if ParamRessHum."Responsable personnel" <> '' then begin
              if Responsable.Get(ParamRessHum."Responsable personnel") then begin
                  wdRange := wdApp.ActiveDocument.Fields.Item(16).Result;
                  wdRange.Text := Responsable."First Name" + ' ' + Responsable."Last Name";
                  wdRange.Bold := 0;

                  wdRange := wdApp.ActiveDocument.Fields.Item(17).Result;
                  wdRange.Text := Responsable."Job Title";
                  wdRange.Bold := 0;
              end
              else begin
                  wdRange := wdApp.ActiveDocument.Fields.Item(16).Result;
                  wdRange.Text := '# Responsable introuvable #';
                  wdRange.Bold := 0;

                  wdRange := wdApp.ActiveDocument.Fields.Item(17).Result;
                  wdRange.Text := '# Responsable introuvable #';
                  wdRange.Bold := 0;
              end;
          end
          else begin
              wdRange := wdApp.ActiveDocument.Fields.Item(16).Result;
              wdRange.Text := '# Responsable non mentionné #';
              wdRange.Bold := 0;

              wdRange := wdApp.ActiveDocument.Fields.Item(17).Result;
              wdRange.Text := '# Responsable non mentionné #';
              wdRange.Bold := 0;
          end;

          wdApp.Visible := true;
          wdApp.ActiveDocument.Fields.Unlink;*/
    end;
}

