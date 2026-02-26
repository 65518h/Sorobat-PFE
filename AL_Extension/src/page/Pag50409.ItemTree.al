page 50409 "Item Tree"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Tree;
    Caption = 'Famille article';
    layout
    {
        area(Content)
        {
            repeater("Famille article")
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;

                }
                // field("Frequence Rotation"; Rec."Frequence Rotation")
                // {
                //     ApplicationArea = all;
                // }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    /*  trigger OnOpenPage()
      begin

          Rec.FILTERGROUP(2);
          CurrentType := Rec.Type::Item;
          Rec.SETRANGE(Type, Rec.Type::Item);
          Rec.FILTERGROUP(0);
          gTreeFormMgt.OnOpenForm(Rec, TempRec, ToggleAll, CurrentType);
      end;

      trigger OnFindRecord(Which: Text): Boolean
      begin

          Found := gTreeFormMgt.OnFindRecord(Rec, TempRec, Which, OkDelete, OkMultiple, ToggleAll, CurrentType);
          IF OkDelete THEN
              CurrPage.UPDATE(FALSE);
          EXIT(Found);
      end;

      trigger OnNextRecord(Steps: Integer): Integer
      begin
          EXIT(gTreeFormMgt.OnNextRecord(Rec, TempRec, Steps));
      end;

      trigger OnNewRecord(BelowxRec: Boolean)
      begin
          Rec.Type := CurrentType;
      end;

      trigger OnAfterGetRecord()
      begin
          ActualExpansionStatus := gTreeFormMgt.GetExpensionStatus(Rec, TempRec, CurrentType);
      end;

      trigger OnInsertRecord(BelowxRec: Boolean): Boolean
      begin

          lIsInsert := gTreeFormMgt.OnInsert(Rec, TempRec);
          EXIT(lIsInsert);
      end;

      trigger OnModifyRecord(): Boolean
      begin

          gTreeFormMgt.OnModify(Rec, TempRec, xCode, ToggleAll, CurrentType);
          CurrPage.UPDATE(FALSE);
          EXIT(FALSE);
      end;

      trigger OnDeleteRecord(): Boolean
      begin

          lIsDelete := gTreeFormMgt.OnDelete(Rec, TempRec, OkMultiple);
          IF OkMultiple THEN BEGIN
              gTreeFormMgt.InitTempTable(TempRec, ToggleAll, CurrentType);
              CurrPage.UPDATE(FALSE);
          END;
          EXIT(lIsDelete);
      end;
  */
    var
        lIsInsert, lIsDelete : Boolean;
        myInt: Integer;
        Found: Boolean;
        gTreeFormMgt: Codeunit "Tree Form management";
        TempRec: Record Tree;
        ActualExpansionStatus: Integer;
        ToggleAll: Boolean;
        buttonOK: Boolean;
        CurrentType: Option;
        OkDelete: Boolean;
        OkMultiple: Boolean;
        xCode: Code[20];

        tNotLowerLevel: label 'Vous ne pouvez sélectionner qu''une ligne de plus bas niveau';
}