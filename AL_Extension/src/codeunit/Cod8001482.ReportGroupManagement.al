Codeunit 8001482 "Report Group Management"
{

    trigger OnRun()
    begin
    end;

    var
        //GL2024 Automation non compatible  gKeyField: Automation Dictionary;
        //GL2024 Automation non compatible  gGroupField: Automation Dictionary;
        gGroupFieldValue: array[255, 255] of Decimal;
        gCurrentKeyFieldValue: array[255] of Text[1024];
        gCurrentKeyRef: KeyRef;
        gChecked: Boolean;
        tErrFieldNo: label 'The Field No. : %1 don''t Exist in the table : %2.';
        tErrKeyRef: label 'The Key used and the grouped field are inconsistent';
        tErrKeyFieldMissing: label 'The keyGroup : %1 is missing of the sort key used';
        tErrNotInitialize: label 'The process are abort, Any Initialization had been does.';


    procedure fAddKeyField(pRecordRef: RecordRef; pFieldNo: Integer)
    var
        lCountRef: Integer;
    begin
        /***********************************************
        *                  fAddKeyField               *
        ***********************************************
        * Entrée : RecordRef                          *
        *        : FieldNo                            *
        * Sortie : Néant                              *
        ***********************************************
        * Add at the list of KeyField, the field      *
        * from the recordRef representated by the     *
        * Field No in parameter                       *
        ***********************************************/
        if (pRecordRef.FieldExist(pFieldNo)) then begin
            //GL2024 Automation non compatible  lCountRef := gKeyField.Count;
            lCountRef += 1;
            //GL2024 Automation non compatible     gKeyField.Add(lCountRef, pFieldNo);
        end else begin
            Error(StrSubstNo(tErrFieldNo, pFieldNo, pRecordRef.Caption));
        end;

    end;


    procedure fAddGroupTotalField(pRecordRef: RecordRef; pFieldNo: Integer)
    var
        lCountRef: Integer;
    begin
        /***********************************************
        *                  fAddKeyField               *
        ***********************************************
        * Entrée : RecordRef                          *
        *        : FieldNo                            *
        * Sortie : Néant                              *
        ***********************************************
        * Add at the list of GroupField, the field    *
        * from the recordRef representated by the     *
        * Field No in parameter                       *
        ***********************************************/
        if (pRecordRef.FieldExist(pFieldNo)) then begin
            //GL2024 Automation non compatible    lCountRef := gGroupField.Count;
            lCountRef += 1;
            //GL2024 Automation non compatible     gGroupField.Add(lCountRef, pFieldNo);
        end else begin
            Error(StrSubstNo(tErrFieldNo, pFieldNo, pRecordRef.Caption));
        end;

    end;

    /*    //GL2024 Automation non compatible 
        procedure fIsKeyFieldChange(pRecordRef: RecordRef;var pFieldRef: FieldRef) retour: Boolean
        var
            lKeyFieldValue: array [255] of Text[1024];
            lKeyFieldIndexChanged: Integer;
            lIndex: Integer;
            lFieldNo: Integer;
        begin

            retour := false;
            if ((gKeyField.Count <> 0) and (gCurrentKeyRef.FieldCount <> 0)) then begin
              //IF (NOT gChecked) THEN BEGIN
              //  fCheckField();
              //END;
              if (gCurrentKeyFieldValue[1] = '') then begin
                lIndex := 1;
                lFieldNo := gKeyField.Item(lIndex);
                pFieldRef := pRecordRef.Field(lFieldNo);
                fCreateKeyFieldValue(pRecordRef, gCurrentKeyFieldValue);
                retour := true;
              end else begin
                // calcul du keyfieldvalue
                fCreateKeyFieldValue(pRecordRef, lKeyFieldValue);
                // Check if changed
                lKeyFieldIndexChanged := fCheckChangedKeyField(gCurrentKeyFieldValue, lKeyFieldValue);
                if (lKeyFieldIndexChanged = 0) then begin
                  fCumulateTotalField(pRecordRef);
                end else begin
                  fCumulateAndResetTotalField(pRecordRef, lKeyFieldIndexChanged);
                  lFieldNo := gKeyField.Item(lKeyFieldIndexChanged);
                  pFieldRef := pRecordRef.Field(lFieldNo);
                  // On positionne le nouveau keyfieldCourant
                  fCreateKeyFieldValue(pRecordRef, gCurrentKeyFieldValue);
                  retour := true;
                end;
              end;
            end else begin
              Error(tErrNotInitialize);
            end;
            exit(retour);

        end;

    *//*//GL2024 Automation non compatible
        procedure fGetGroupTotalFieldValue(pGroupFieldNo: Integer;pFromKeyFieldNo: Integer) retour: Decimal
        var
            lIndexGroupField: Integer;
            lIndexKeyField: Integer;
            lIndex: Integer;
            lFieldRef: FieldRef;
        begin

            retour := 0;
            lIndex := 1;
            lIndexGroupField := 0;
            repeat
              lFieldRef := gGroupField.Item(lIndex);
              if (lFieldRef.Number = pGroupFieldNo) then
                lIndexGroupField := lIndex;
              lIndex += 1;
            until ((lIndex > gGroupField.Count) or (lIndexGroupField <> 0));
            lIndex := 1;
            lIndexKeyField := 0;
            repeat
              lFieldRef :=gKeyField.Item(lIndex);
              if (lFieldRef.Number = pFromKeyFieldNo) then
                lIndexKeyField := lIndex;
              lIndex += 1;
            until ((lIndex > gKeyField.Count) or (lIndexKeyField <> 0));
            if ((lIndexGroupField <> 0) and (lIndexKeyField <> 0)) then begin
              retour := gGroupFieldValue[lIndexGroupField][lIndexKeyField];
            end;

        end;
    */

    procedure fInitialize(pRecordRef: RecordRef)
    begin
        /***********************************************
        *                 fInitialize                 *
        ***********************************************
        * Entrée : pRecordRef                         *
        * Sortie : Néant                              *
        ***********************************************
        * Initialize the Group Management with the    *
        * parameters recordref                        *
        ***********************************************/
        ClearAll();
        gChecked := false;
        //GL2024 Automation non compatible   Create(gKeyField, false, true);
        //GL2024 Automation non compatible   Create(gGroupField, false, true);
        gCurrentKeyRef := pRecordRef.KeyIndex(pRecordRef.CurrentKeyIndex);

    end;


    procedure fFinalize()
    begin
        /***********************************************
        *                   fFinalize                 *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Destroy all components                      *
        ***********************************************/
        gChecked := false;
        //GL2024 Automation non compatible Clear(gKeyField);
        //GL2024 Automation non compatible  Clear(gGroupField);
        ClearAll();

    end;


    procedure fInitCurrentKey(pRecordRef: RecordRef)
    begin
        gCurrentKeyRef := pRecordRef.KeyIndex(pRecordRef.CurrentKeyIndex);
    end;

    local procedure fCheckField()
    var
        lFieldFound: Boolean;
        lIndexKeyRef: Integer;
        lIndexKeyField: Integer;
        lFieldNo: Integer;
        lIndex: Integer;
        lFieldRef: FieldRef;
    begin
        /***********************************************
        *                   fCheckField               *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * Check wether the KeyField are in adequation *
        * with the key ref                            *
        ***********************************************/
        lFieldFound := true;
        lIndexKeyField := 1;
        /* //GL2024 Automation non compatible  while ((lIndexKeyField < gKeyField.Count) and (lFieldFound)) do begin
               lIndexKeyRef := 1;
               lFieldFound := false;
            //GL2024 Automation non compatible   lFieldNo := gKeyField.Item(lIndexKeyField);
               repeat
                   lFieldRef := gCurrentKeyRef.FieldIndex(lIndexKeyRef);
                   if (lFieldRef.Number = lFieldNo) then
                       lFieldFound := true;
                   lIndexKeyRef := lIndexKeyRef + 1;
               until ((lIndexKeyRef > gCurrentKeyRef.FieldCount) or (lFieldFound));
               lIndexKeyField := lIndexKeyField + 1;
           end;*/
        if (not lFieldFound) then begin
            lIndex := lIndexKeyField - 1;
            //GL2024 Automation non compatible  lFieldNo := gKeyField.Item(lIndex);
            Error(tErrKeyFieldMissing, lFieldNo);
        end;
        gChecked := true;

    end;
    /*//GL2024 Automation non compatible
        local procedure fCreateKeyFieldValue(pRecordRef: RecordRef; var pFieldsValue: array[255] of Text[1024])
        var
            lFieldRef: FieldRef;
            lIndex: Integer;
            lFieldNo: Integer;
        begin

            for lIndex := 1 to gKeyField.Count do begin
                lFieldNo := gKeyField.Item(lIndex);
                lFieldRef := pRecordRef.Field(lFieldNo);
                if ((Format(lFieldRef.Type) in ['Binary', 'BLOB']) or (Format(lFieldRef.CLASS) = 'FlowField')) then
                    lFieldRef.CalcField();
                pFieldsValue[lIndex] := Format(lFieldRef.Value);
            end;

        end;*/

    /* //GL2024 Automation non compatible
    local procedure fCheckChangedKeyField(pCurrent: array[255] of Text[1024]; pNew: array[255] of Text[1024]) retour: Integer
     var
         lIndex: Integer;
     begin

         retour := 0;
         lIndex := 1;
         repeat
             if (pCurrent[lIndex] <> pNew[lIndex]) then
                 retour := lIndex;
             lIndex := lIndex + 1;
         until ((lIndex > gKeyField.Count) or (retour <> 0));
         exit(retour);

     end;
 */

    /*
    //GL2024 Automation non compatible
        local procedure fCumulateTotalField(pRecordRef: RecordRef)
        var
            lFieldRef: FieldRef;
            lIndexKeyField: Integer;
            lIndexTotalField: Integer;
            lValue: Decimal;
            lFieldNo: Integer;
            lFieldValue: Text[255];
        begin

            lIndexTotalField := 1;
            for lIndexTotalField := 1 to gGroupField.Count do begin
                lFieldNo := gGroupField.Item(lIndexTotalField);
                lFieldRef := pRecordRef.Field(lFieldNo);
                if (Format(lFieldRef.CLASS) = 'FlowField') then
                    lFieldRef.CalcField();
                lFieldValue := Format(lFieldRef.Value);
                if (lFieldValue = '') then
                    lFieldValue := '0';
                Evaluate(lValue, lFieldValue);
                // We cumulate this value for each KeyField
                lIndexKeyField := 1;
                for lIndexKeyField := 1 to gKeyField.Count do begin
                    gGroupFieldValue[lIndexTotalField] [lIndexKeyField] += lValue;
                end;
            end;

        end;
    */

    /*//GL2024 Automation non compatible
        local procedure fCumulateAndResetTotalField(pRecordRef: RecordRef; pIndexKeyField: Integer)
        var
            lFieldRef: FieldRef;
            lIndexKeyField: Integer;
            lIndexTotalField: Integer;
            lValue: Decimal;
            lFieldNo: Integer;
            lFieldValue: Text[255];
        begin

            lIndexTotalField := 1;
            for lIndexTotalField := 1 to gGroupField.Count do begin
                lFieldNo := gGroupField.Item(lIndexTotalField);
                lFieldRef := pRecordRef.Field(lFieldNo);
                if (Format(lFieldRef.CLASS) = 'FlowField') then
                    lFieldRef.CalcField();
                lFieldValue := Format(lFieldRef.Value);
                if (lFieldValue = '') then
                    lFieldValue := '0';
                Evaluate(lValue, lFieldValue);
                // We cumulate this value for each KeyField
                lIndexKeyField := 1;
                for lIndexKeyField := 1 to gKeyField.Count do begin
                    if (lIndexKeyField < pIndexKeyField) then
                        gGroupFieldValue[lIndexTotalField] [lIndexKeyField] += lValue;
                    if (lIndexKeyField = pIndexKeyField) then
                        gGroupFieldValue[lIndexTotalField] [lIndexKeyField] := lValue;
                    if (lIndexKeyField > pIndexKeyField) then
                        gGroupFieldValue[lIndexTotalField] [lIndexKeyField] := 0;
                end;
            end;

        end;*/
}

