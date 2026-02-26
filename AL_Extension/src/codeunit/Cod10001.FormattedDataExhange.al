namespace SOROUBAT_BF.SOROUBAT_BF;
using Microsoft.Bank.Reconciliation;
using System.Utilities;
using System.IO;

codeunit 50025 "Formatted Data Exhange"
{
    // DYS JALEL SHAIEK 0601225 Codeunit to exclude footer lines during formatted data exchange processing
    Permissions = TableData "Data Exch. Field" = rimd,
               TableData "Data Exch." = rimd,
                TableData "Bank Acc. Reconciliation" = rimd,
                TableData "Bank Acc. Reconciliation Line" = rimd,
                TableData "Data Exch. Def" = rimd;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Read Data Exch. from File", OnRunOnBeforeGetTable, '', false, false)]
    local procedure "Read Data Exch. from File_OnRunOnBeforeGetTable"(var TempBlob: Codeunit "Temp Blob"; DataExch: Record "Data Exch.")
    var
        InS: InStream;
        OutS: OutStream;
        OutsFileContent: OutStream;
        LineTxt: Text;
        Fields: List of [Text];
        NewTempBlob: Codeunit "Temp Blob";
        DataExchDef: Record "Data Exch. Def";
    begin
        if DataExchDef.Get(DataExch."Data Exch. Def Code") then;
        if DataExchDef."Etiquette Footer1" = '' then
            exit;
        // Lire le fichier original
        TempBlob.CreateInStream(InS);
        //DataExch."File Content".CreateInStream(InS);
        // Préparer un nouveau flux nettoyé
        NewTempBlob.CreateOutStream(OutS);

        while not InS.EOS do begin
            InS.ReadText(LineTxt);

            Fields := LineTxt.Split(';');

            // Ignorer lignes TOTAL / SOLDE
            if not IsFooterLine(Fields, DataExchDef."Etiquette Footer1", DataExchDef."Colonne Footer1", DataExchDef."Etiquette Footer2") then begin
                OutS.WriteText(LineTxt);
                OutS.WriteText();
            end;
        end;

        // Remplacer le contenu du TempBlob original
        // TempBlob.Clear();
        Clear(TempBlob);
        NewTempBlob.CreateInStream(InS);
        TempBlob.CreateOutStream(OutS);
        CopyStream(OutS, InS);
    end;

    // ----------------------------
    // Détection lignes à exclure
    // ----------------------------
    local procedure IsFooterLine(Fields: List of [Text]; etiquettefooter1: Text; colonnefooter1: Integer; etiquettefooter2: Text): Boolean
    begin
        if Fields.Count >= colonnefooter1 then begin
            if Fields.Get(colonnefooter1) = etiquettefooter1 then
                exit(true);

            if StrPos(UpperCase(Fields.Get(colonnefooter1)), UpperCase(etiquettefooter2)) > 0 then
                exit(true);
        end;
        exit(false);
    end;




}