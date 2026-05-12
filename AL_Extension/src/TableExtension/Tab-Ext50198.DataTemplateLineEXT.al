TableExtension 50198 "Data Template LineEXT" extends "Config. Template Line"
{
    fields
    {
        modify("Default Value")
        {
            trigger OnAfterValidate()
            var
                FieldRef: FieldRef;
            begin
                if ("Field ID" <> 0) and ("Default Value" <> '') then begin
                    //  +REF+TEMPLATE
                    IF FORMAT(FieldRef.TYPE) = 'Boolean' THEN BEGIN
                        "Default Value" := FORMAT(FieldRef.VALUE);
                        IF "Default Value" = FORMAT(TRUE) THEN
                            "Default Value" := FORMAT(1)
                        ELSE
                            "Default Value" := FORMAT(0);
                    END ELSE
                        IF FORMAT(FieldRef.TYPE) = 'Option' THEN // Keep option number
                            "Default Value" := FORMAT(FieldRef.VALUE)
                        ELSE
                            "Default Value" := Format(FieldRef.Value);
                    //+REF+TEMPLATE//
                end;
            end;

            /*GL2024  trigger OnLookup()
              var
                  lRecRef: RecordRef;
                  lFieldRef: FieldRef;
                  lTableRelation: Codeunit 8001408;
                  lCode: Code[20];
                  lInteger: Integer;
              begin

                  //+REF+TEMPLATE
                  //GL2024 IF FieldID <> 0 THEN BEGIN
                  //GL2024
                  IF "Table ID" <> 0 THEN BEGIN
                      //GL2024
                      //GL2024
                      lRecRef.OPEN("Table ID", TRUE);
                      //GL2024
                      //GL2024  lRecRef.OPEN(TableID, TRUE);


                      //GL2024
                      lFieldRef := lRecRef.FIELD("Table ID");
                      //GL2024

                      //GL2024    lFieldRef := lRecRef.FIELD(FieldID);
                      IF lFieldRef.RELATION <> 0 THEN BEGIN
                          lCode := "Default Value";
                          //GL2024
                          IF lTableRelation.LookUp("Table ID", "Table ID", lCode) THEN
                              //GL2024
                              //GL2024 IF lTableRelation.LookUp(TableID, FieldID, lCode) THEN
                              "Default Value" := lCode;
                      END ELSE
                          IF FORMAT(lFieldRef.TYPE) = 'Option' THEN BEGIN
                              IF "Default Value" <> '' THEN
                                  EVALUATE(lInteger, "Default Value");
                              lInteger := STRMENU(FORMAT(lFieldRef.OPTIONCAPTION), lInteger + 1);
                              IF lInteger <> 0 THEN
                                  "Default Value" := FORMAT(lInteger - 1);
                          END ELSE
                              IF FORMAT(lFieldRef.TYPE) = 'Boolean' THEN BEGIN
                                  IF "Default Value" <> '' THEN
                                      EVALUATE(lInteger, "Default Value");
                                  lInteger := STRMENU(FORMAT(FALSE) + ',' + FORMAT(TRUE), lInteger + 1);
                                  IF lInteger <> 0 THEN
                                      "Default Value" := FORMAT(lInteger - 1);
                              END;
                  END
                  //+REF+TEMPLATE//
              end;*/
        }


        field(50000; "ID Champs Synchronisation"; Integer)
        {
            Caption = 'FieldID';
            Editable = false;

            /*GL2024 trigger OnLookup()
              begin
                  TestField(FieldID);
                  Clear(FieldList);
                  FieldRec.SetRange(FieldRec.TableNo, 50000);
                  FieldList.SetTableview(FieldRec);
                  FieldList.LookupMode := true;
                  if FieldList.RunModal = Action::LookupOK then begin
                      FieldList.GetRecord(FieldRec);
                      TableID := FieldRec.TableNo;
                      "ID Champs Synchronisation" := FieldRec."No.";
                      "Descrip Champs Synchronisation" := FieldRec."Field Caption";
                  end;
              end;*/

            trigger OnLookup()
            begin
                //DYS a verifier
                // TestField("Table ID");
                // Clear(FieldList);
                // FieldRec.SetRange(FieldRec.TableNo, 50000);
                // FieldList.SetTableview(FieldRec);
                // FieldList.LookupMode := true;
                // if FieldList.RunModal = Action::LookupOK then begin
                //     FieldList.GetRecord(FieldRec);
                //     "Table ID" := FieldRec.TableNo;
                //     "ID Champs Synchronisation" := FieldRec."No.";
                //     "Descrip Champs Synchronisation" := FieldRec."Field Caption";
                // end;
            end;
        }
        field(50001; "Descrip Champs Synchronisation"; Text[250])
        {
            Caption = 'Field Caption';
            Editable = false;
        }
        field(50002; "Article de service"; Boolean)
        {
            Caption = 'Article de service';

        }

    }

    var
        FieldRec: Record Field;
    //DYS page obsolet
    //FieldList: page 6218;
}

