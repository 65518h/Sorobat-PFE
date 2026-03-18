Table 8001434 "BOQ Line"
{
    // #7208 XPE 30/04/09 Lors de la recherche de la valeur d'une variable reference, on test la possibilité
    // #7208 XPE 30/04/09 de "caster" la valeur, si cela echou la valeur est initialisé à ZERO
    // #7208 XPE 30/04/09 Lors de la selection d'un champs pour une variable referencée, on verifie son type de donnée
    // #7208 XPE 30/04/09 Si celui ne correspond à un decimal ou un entier, un message d'erreur est affiché
    // #7195 XPE 29/04/09 Modification du formulaire appelé pour obtenir le nom des champs d'une table
    // #7141 XPE 16/04/09 Ajout de la gestion des variables references pour les cas particuliers
    // #7141 XPE 16/04/09 * ouvrage, dÚtail ouvrage et modele de metre
    // //#6711 Ajout
    // //#6591 Essai

    Caption = 'Bill of Quantity Line';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Variable Code"; Code[20])
        {
            Caption = 'Variable Code';

            trigger OnValidate()
            var
                lChar: Char;
                i: Integer;
                t: Integer;
            begin
                fVerifyUndefinied;
                if ("Variable Code" = '') then
                    exit;
                if not Codeunit.Run(Codeunit::"BOQ Calculate Mgt", Rec) then begin
                    lText := GetLastErrorText;
                    lChar := 13;
                    lText := CopyStr(lText, StrPos(lText, Format(lChar)) + 1);
                    lText := CopyStr(lText, StrPos(lText, Format(lChar)) + 1);
                    lText := CopyStr(lText, StrPos(lText, Format(lChar)) + 1);
                    Error(lText);
                    ClearLastError;
                end;
            end;
        }
        field(3; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(4; Value; Decimal)
        {
            Caption = 'Value';
            DecimalPlaces = 0 : 6;

            trigger OnValidate()
            begin
                fVerifyUndefinied;
            end;
        }
        field(5; "Field No."; Integer)
        {
            Caption = 'Field No.';

            trigger OnLookup()
            var
                lObj: Record "Field";
                lRecID: RecordID;
                lT37: Record "Sales Line";
                lTableNo: Integer;
            begin
                TestField("Variable Code");
                lRecID := Rec.RecordID;
                //#7141
                // Gros cas particulier
                lTableNo := fGetTableNo(lRecID.TableNo, true);
                //lObj.SETRANGE(TableNo,lRecID.TABLENO);
                lObj.SetRange(TableNo, lTableNo);
                //#7141//
                if not lObj.IsEmpty then begin
                    //#7141
                    //IF NOT lObj.GET(lRecID.TABLENO,"Field No.") THEN
                    if not lObj.Get(lTableNo, "Field No.") then
                        //#7141
                        lObj.FindFirst;
                    //#7195
                    //DYS page Addon non migrer
                    // if PAGE.RunModal(page::"Field List BGW", lObj) = Action::LookupOK then begin
                    //     //#7208
                    //     if ((lObj.Type = lObj.Type::Decimal) or
                    //        (lObj.Type = lObj.Type::Integer) or
                    //        (lObj.Type = lObj.Type::BigInteger)) then begin
                    //         "Field No." := lObj."No.";
                    //         Description := lObj."Field Caption";
                    //         Value := 0;
                    //     end else begin
                    //         Error(StrSubstNo(tErrorTypeField, lObj."Field Caption"));
                    //     end;
                    //     //#7208//
                    //     //#7195//
                    // end;
                end;

                fVerifyUndefinied;
            end;

            trigger OnValidate()
            var
                lObj: Record "Field";
                lRecID: RecordID;
                lTableNo: Integer;
            //lFormFieldList: Page 8001441;
            begin
                Value := 0;
                if "Field No." = 0 then
                    exit;
                lRecID := Rec.RecordID;
                //#7141
                lTableNo := fGetTableNo(lRecID.TableNo, false);
                //lObj.GET(lRecID.TABLENO,"Field No.");
                lObj.Get(lTableNo, "Field No.");
                //#7208
                if ((lObj.Type = lObj.Type::Decimal) or
                    (lObj.Type = lObj.Type::Integer) or
                     (lObj.Type = lObj.Type::BigInteger)) then begin
                    "Field No." := lObj."No.";
                    //#7195

                    Description := lObj."Field Caption";
                    //#7195//
                end else begin
                    Error(StrSubstNo(tErrorTypeField, lObj."Field Caption"));
                end;
                //#7208//

                fVerifyUndefinied;
            end;
        }
        field(6; Formula; Text[250])
        {
            Caption = 'Formula';

            trigger OnValidate()
            begin
                fVerifyUndefinied;
            end;
        }
        field(7; Undefined; Boolean)
        {
            Caption = 'Undefined';
        }
        field(8; Problem; Boolean)
        {
            Caption = 'Error';
        }
        field(9; RecordID; RecordID)
        {
            Caption = 'RecordID';
        }
        field(10; Level; Integer)
        {
            Caption = 'LEvel';
        }
        field(11; Substituted; Boolean)
        {
            Caption = 'Substituted';
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //#6711
        fVerifiyFormula;
        fVerifyUndefinied;
        fVerifyResult;
        //#6711//
    end;

    trigger OnModify()
    begin
        //#6711
        fVerifiyFormula;
        fVerifyUndefinied;
        fVerifyResult
        //#6711//
    end;

    var
        lText: Text[1024];
        tVarExist: label 'The Variable Code already exist in this scope.';
        tErrorFormula: label 'The Formula contain a syntax error\Evaluation Canceled';
        tErrorResult: label 'You can input the fields "Value" and "No. field", only if you enter a variable code';
        tErrorValueField: label 'You can input the "Value" field, only if you are enter a variable code';
        tErrorNoFiled: label 'You can input the "No. Field" field, only if you are enter a variable code';
        tListTable: label 'Sales Header,Sales Line';
        tErrorTypeField: label 'The Datatype if Field %1 is''t valid';


    procedure fExtractRecordValue() return: Decimal
    var
        lRecordref: RecordRef;
        lFieldRef: FieldRef;
    begin
        if "Field No." = 0 then
            exit(Value);
        lRecordref.Get(RecordID);
        lFieldRef := lRecordref.Field("Field No.");
        if Format(lFieldRef.CLASS) = 'FlowField' then
            lFieldRef.CalcField;
        //#7208
        if (not Evaluate(Value, Format(lFieldRef.Value))) then
            Value := 0;
        //#7208//
        exit(Value);
    end;


    procedure fVerifiyFormula()
    var
        lChar: Char;
    begin
        //#6711
        if (Formula = '') then
            exit;
        if not Codeunit.Run(Codeunit::"BOQ Calculate Mgt", Rec) then begin
            lText := GetLastErrorText;
            lChar := 13;
            lText := CopyStr(lText, StrPos(lText, Format(lChar)) + 1);
            lText := CopyStr(lText, StrPos(lText, Format(lChar)) + 1);
            lText := CopyStr(lText, StrPos(lText, Format(lChar)) + 1);
            Error(tErrorFormula);
            ClearLastError;
        end;
        //#6711//
    end;


    procedure fVerifyUndefinied()
    begin
        Undefined := (("Variable Code" <> '') and (Formula = '') and ("Field No." = 0) and (Value = 0));
    end;


    procedure fVerifyResult()
    begin
        if (("Variable Code" = '') and (Formula = '')) then begin
            if (("Field No." <> 0) and (Value = 0)) then
                Error(tErrorNoFiled);
            if (("Field No." = 0) and (Value <> 0)) then
                Error(tErrorValueField);
            if (("Field No." <> 0) and (Value <> 0)) then
                Error(tErrorResult);
        end;
    end;


    procedure fGetTableNo(pSrcTableNo: Integer; pShowMenu: Boolean) Retour: Integer
    var
        lSelection: Integer;
    begin
        //#7141
        // SI OUVRAGE OU DETAIL OUVRAGE ALORS TABLENO = 37
        // SI MODELE METRE ALOS POSSIBILITE DE CHOISIR ENTR TABLE 36 OU TABLE 37
        lSelection := 0;
        case (pSrcTableNo) of
            Database::Resource:
                begin
                    Retour := Database::"Sales Line";
                end;
            Database::"Structure Component":
                begin
                    Retour := Database::"Sales Line";
                end;
            Database::"BOQ Template":
                begin
                    if (pShowMenu) then
                        lSelection := StrMenu(tListTable, 2);
                    case lSelection of
                        0:
                            begin
                                // Rien selectionné
                                // alorts default table 37
                                Retour := Database::"Sales Line";
                            end;
                        1:
                            begin
                                //Table 36
                                Retour := Database::"Sales Header";
                            end;
                        2:
                            begin
                                // Table 37
                                Retour := Database::"Sales Line";
                            end;
                        else begin
                            // DEFAULT
                            Retour := Database::"Sales Line";
                        end;
                    end;
                end;
            else begin
                Retour := pSrcTableNo;
            end;
        end;
        //#7141//
    end;
}

