Table 8003929 Tree
{
    // //AFF PLAN PLANNINGFORCE OFE 12/06/09
    // //PIED_DEVIS MB 04/01/07 Ajout de l'option Autre dans le champ Type
    // //TREE MB 21/12/2006 Autoriser l'affectation d'un article ou d'un ouvrage a une famille meme si elle a des sous familles
    //                      Renommer une famille
    // //PYRAMID CW 28/10/03 Codification arborescente
    // //+REF+REPLIC AC 28/06/05 OnInsert, OnModify, OnDelete, OnRename
    //                           + field "Replication" (ID = 73754 ), boolean, editable=No
    // //PLA AC 01/04/09 Ajout option dans type

    Caption = 'Tree';
    //  LookupPageID = 8003973; 

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Person,Machine,Structure,Item,NACE,Doc. Footer,Skill,Resource Group';
            OptionMembers = Person,Machine,Structure,Item,NACE,Other,Skill,"Resource Group";
        }
        field(2; "Code"; Text[20])
        {
            Caption = 'Famille';

            trigger OnValidate()
            var
                i: Integer;
            begin
                Code := UpperCase(Code);
                Level := 0;
                for i := 1 to StrLen(Code) do
                    if Code[i] = ' ' then
                        Level += 1;
            end;
        }
        field(3; Description; Text[80])
        {
            Caption = 'Désignation';
        }
        field(4; Level; Integer)
        {
            Caption = 'Niveau';
        }
        field(50000; Synchronise; Boolean)
        {
        }

        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; Type, "Code")
        {
            Clustered = true;
        }
        key(STG_Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //CheckDelete;
        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnInsert()
    begin

        CheckInsert;
        //+REF+REPLIC
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnModify()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnRename()
    var
        lReplicationRef: RecordRef;
    begin
        //TREE
        //CheckInsert;
        //  CheckRename(xRec.Code);
        //TREE//
        //+REF+REPLIC
        lReplicationRef.GetTable(xRec);
        wReplicationRef.GetTable(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;

    var
        tUpperLevelNotExists: label 'Upper level doesn''t exists';
        HideDialog: Boolean;
        tDeleteLowerLevel: label 'Do you want to delete the selected line with their lower lines?';
        lItem: Record Item;
        tStillUsed: label 'You can''t delete this line. It''s still used %1 times from %2';
        tRenameLowerLevel: label 'Do you want to rename this line with its lower lines?';
        i: Integer;
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        tNotLowerLevel: label 'You must select a low-level line';


    procedure SetHideDialog(pHideDialog: Boolean)
    begin
        HideDialog := pHideDialog;
    end;


    procedure CheckInsert()
    var
        lRec: Record Tree;
        i: Integer;
    begin
        // Used from FORM.OnInsert
        if StrPos(Code, ' ') = 0 then
            exit;
        lRec := Rec;
        i := StrLen(Code);
        repeat
            i -= 1;
        until (i = 1) or (lRec.Code[i] = ' ');
        if i > 1 then
            if not lRec.Get(lRec.Type, CopyStr(lRec.Code, 1, i - 1)) then
                Error(tUpperLevelNotExists);
    end;


    procedure CheckDelete(var pOkMultiple: Boolean)
    var
        lRec: Record Tree;
    begin
        // Used from FORM.OnDelete
        if not HideDialog then begin
            lRec.SetRange(Type, Type);
            if StrLen(Code) <= MaxStrLen(Code) - 2 then
                lRec.SetFilter(Code, '%1|%2', Code + ' *', Code)
            else
                lRec.SetRange(Code, Code);
            if lRec.Find('-') then begin
                if not pOkMultiple and (lRec.Count > 1) then
                    pOkMultiple := Confirm(tDeleteLowerLevel, false)
                else
                    pOkMultiple := true;
                if pOkMultiple then begin
                    repeat
                        lRec.SetHideDialog(true);
                        lRec.Delete(true);
                    until lRec.Next = 0;
                end
                else
                    Error('');
            end;
        end;
        if Type = Database::Item then begin
            lItem.SetCurrentkey("Tree Code");
            lItem.SetRange("Tree Code", Code);
            if lItem.Find('-') then
                Error(tStillUsed, lItem.Count, lItem."No.");
        end;
    end;


    procedure CheckRename(pOldCode: Code[20])
    var
        lRec: Record Tree;
        lRec2: Record Tree;
        lOk: Boolean;
        lCode: Code[20];
        lNewCode: Code[20];
        lTree: Record Tree;
        lItem: Record Item;
        lItem2: Record Item;
        lRes: Record Resource;
        lRes2: Record Resource;
    begin
        // Used from FORM.OnModify
        if not HideDialog then begin
            lRec.SetRange(Type, Type);
            if StrLen(pOldCode) <= MaxStrLen(Code) - 2 then
                lRec.SetFilter(Code, '%1|%2', pOldCode + ' *', pOldCode)
            else
                lRec.SetRange(Code, pOldCode);
            if lRec.Find('-') then begin
                if (lRec.Count > 1) then
                    lOk := Confirm(tRenameLowerLevel, false)
                else
                    lOk := true;
                if lOk then begin
                    repeat
                        //TREE
                        lRec2.Get(lRec.Type, lRec.Code);
                        if lRec2.Code <> pOldCode then
                            lCode := lNewCode + CopyStr(lRec.Code, StrLen(lNewCode) + 1, StrLen(lRec.Code) - StrLen(lNewCode))
                        else
                            lCode := lNewCode;

                        lNewCode := Code;

                        case Type of
                            Type::Item:
                                begin
                                    lItem.SetCurrentkey("Tree Code");
                                    lItem.SetRange("Tree Code", lRec.Code);
                                    if not lItem.IsEmpty then begin
                                        lItem.Find('-');
                                        repeat
                                            lItem2.Get(lItem."No.");
                                            lItem2."Tree Code" := lCode;
                                            lItem2.Modify;
                                        until lItem.Next = 0;
                                    end;
                                end;
                            Type::Person, Type::Machine, Type::Structure:
                                begin
                                    lRes.SetCurrentkey("Tree Code");
                                    lRes.SetRange("Tree Code", lRec.Code);
                                    if not lRes.IsEmpty then begin
                                        lRes.Find('-');
                                        repeat
                                            lRes2.Get(lRes."No.");
                                            lRes2."Tree Code" := lCode;
                                            lRes2.Modify;
                                        until lRes.Next = 0;
                                    end;
                                end;
                        end;

                        lRec2.Get(lRec.Type, lRec.Code);
                        if lRec2.Code <> pOldCode then
                            lCode := lNewCode + CopyStr(lRec.Code, StrLen(lNewCode) + 1, StrLen(lRec.Code) - StrLen(lNewCode))
                        else
                            lCode := lNewCode;

                        //        lRec2.Code := lCode;
                        //        FOR i := 1 TO STRLEN(Code) DO
                        //          lCode[i] := Code[i];
                        lRec2.SetHideDialog(true);
                        lRec2.Rename(lRec2.Type, lCode);
                    //        lRec2.MODIFY;
                    until lRec.Next = 0;
                    //TREE//
                end
                else
                    Error('');
            end;
        end;
    end;


    procedure LookUpForm(pType: Integer; pCode: Code[20]): Code[20]
    begin
        case pType of
            //DYS PAGE ADDON NON MIGRER
            Type::Item:
                if Action::LookupOK = PAGE.RunModal(page::"Item Tree", Rec) then
                    exit(Code);
            // Type::Person:
            //     if Action::LookupOK = PAGE.RunModal(page::"Person Tree", Rec) then
            //         exit(Code);
            // Type::Structure:
            //     if Action::LookupOK = PAGE.RunModal(page::"Structure Tree", Rec) then
            //         exit(Code);
            // Type::Machine:
            //     if Action::LookupOK = PAGE.RunModal(page::"Machin Tree", Rec) then
            //         exit(Code);
            // Type::NACE:
            //     if Action::LookupOK = PAGE.RunModal(page::"Sales Prepayments", Rec) then
            //         exit(Code);
            // //#8259
            // Type::"Resource Group":
            //     if Action::LookupOK = PAGE.RunModal(page::"Res. Grp. Tree", Rec) then
            //         exit(Code);
            //#8259//
            else
                ;
        end;
        exit(pCode);
    end;


    procedure OnValidate(pType: Integer; var pCode: Text[20])
    var
        lRec: Record Tree;
    begin
        if (pCode = '') or (StrLen(pCode) >= MaxStrLen(Code) - 1) then
            exit;
        //TREE
        /*SETRANGE(Type,pType);
        SETFILTER(Code,pCode + ' *');
        IF NOT ISEMPTY THEN
          ERROR(tNotLowerLevel);*/
        //TREE//

    end;


    procedure OnLookUp(pType: Integer; var pCode: Text[20])
    begin
        SetRange(Type, pType);
        SetFilter(Code, pCode);
        if Find('-') then;
        SetRange(Code);
        pCode := LookUpForm(pType, pCode);
    end;
}

