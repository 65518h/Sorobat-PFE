//GL3900 
// Page 72169 "ident_equip final"
// {//GL2024  ID dans Nav 2009 : "39002169"
//     //  STRSUBSTNO('%1%2',

//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = Liens;
//     SourceTableView = sorting(Arbre, identation)
//                       order(ascending);
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000014)
//             {
//                 IndentationColumn = cd_box_linkIndent;
//                 IndentationControls = cd_box_link;
//                 field(ActualExpansionStatus; ActualExpansionStatus)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     //  OptionCaption = 'Integer';

//                     trigger OnValidate()
//                     begin
//                         ActualExpansionStatusOnPush;
//                     end;
//                 }
//                 field(typ_subtype; Rec.typ_subtype)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(cd_box; Rec.cd_box)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(cd_box_link; Rec.cd_box_link)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(identation; Rec.identation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Action1000000000)
//             {
//                 ApplicationArea = Basic;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     box.Reset;
//                     box.SetFilter(box.cd_box, Rec.cd_box_link);
//                     if box.Find('-') then
//                         PAGE.Run(50605, box)
//                     else
//                         Message('No');
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         cd_box_linkIndent := 0;
//         if IsExpanded(Rec) then
//             ActualExpansionStatus := 1
//         else
//             if HasChildren(Rec) then
//                 ActualExpansionStatus := 0
//             else
//                 ActualExpansionStatus := 2;
//         cdboxlinkOnFormat;
//     end;

//     trigger OnFindRecord(Which: Text): Boolean
//     var
//         found: Boolean;
//     begin
//         TempRec.Copy(Rec);
//         found := TempRec.Find(Which);
//         Rec := TempRec;
//         exit(found);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//         RecRef: RecordRef;
//         ChangeLogMgt: Codeunit "Change Log Management";
//     begin
//         TempRec := Rec;
//         RecRef.GetTable(Rec);
//         ChangeLogMgt.LogInsertion(RecRef);
//         exit(TempRec.Insert);
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     var
//         ResultSteps: Integer;
//     begin
//         TempRec.Copy(Rec);
//         ResultSteps := TempRec.Next(Steps);
//         Rec := TempRec;
//         exit(ResultSteps);
//     end;

//     trigger OnOpenPage()
//     begin
//         InitTemplate;
//     end;

//     var
//         ActualExpansionStatus: Integer;
//         TempRec: Record Liens temporary;
//         box: Record Equipement;
//         temp: Record Liens;
//         [InDataSet]
//         cd_box_linkEmphasize: Boolean;
//         [InDataSet]
//         cd_box_linkIndent: Integer;


//     procedure InitTemplate()
//     begin
//         CopyRecToTemp(true);
//     end;


//     procedure CopyRecToTemp(onlyRoot: Boolean)
//     var
//         HierRec: Record Liens;
//     begin
//         TempRec.DeleteAll;
//         TempRec.SetCurrentkey(cd_compo);
//         if onlyRoot then
//             HierRec.SetRange(HierRec.identation, 0);
//         HierRec.SetFilter(HierRec.typ_subtype, '1');
//         if HierRec.Find('-') then
//             repeat
//                 TempRec := HierRec;
//                 TempRec.Insert;
//             until HierRec.Next = 0;
//     end;


//     procedure ToogleExpand(compo: Record Liens)
//     begin
//         if ActualExpansionStatus = 0 then begin // Has children, but not expanded

//             /* compo.SETFILTER(typ_subtype,'1');
//              compo.SETFILTER(compo.cd_box,cd_box_link);
//              compo.SETRANGE(identation,identation + 1);
//              compo := Rec;*/
//             temp.Reset;
//             temp.SetFilter(temp.cd_box, compo.cd_box_link);
//             temp.SetRange(temp.identation, compo.identation + 1);
//             compo := temp;

//             //IF compo.NEXT <> 0 THEN
//             if temp.Find('-') then
//                 repeat
//                     if temp.identation > Rec.identation then begin
//                         TempRec := temp;
//                         TempRec.SetCurrentkey(TempRec.tri);
//                         // temprec.ascending(false);
//                         if TempRec.Insert then;
//                     end;
//                 until (temp.Next = 0) or (temp.identation = Rec.identation);
//         end else
//             if ActualExpansionStatus = 1 then begin // Has children and is already expanded
//                 TempRec := Rec;
//                 while (TempRec.Next <> 0) and (TempRec.identation > Rec.identation) do
//                     TempRec.Delete;
//             end;
//         CurrPage.Update;

//     end;


//     procedure HasChildren(ActualRec: Record Liens): Boolean
//     var
//         compo: Record Liens;
//     begin
//         compo := ActualRec;

//         compo.Reset;
//         compo.SetFilter(compo.cd_box, ActualRec.cd_box_link);

//         //IF compo.NEXT = 0 THEN
//         if not compo.Find('-') then
//             exit(false)
//         else
//             exit(compo.identation > ActualRec.identation);
//     end;


//     procedure IsExpanded(ActualRec: Record Liens): Boolean
//     begin
//         TempRec := ActualRec;

//         TempRec.Reset;
//         TempRec.SetFilter(TempRec.cd_box, ActualRec.cd_box_link);

//         //IF TempRec.NEXT = 0 THEN
//         if not TempRec.Find('-') then
//             exit(false)
//         else
//             exit(TempRec.identation > ActualRec.identation);
//     end;


//     procedure ExpandAll()
//     begin
//         CopyRecToTemp(false);
//     end;

//     local procedure ActualExpansionStatusOnPush()
//     begin
//         ToogleExpand(Rec);
//     end;

//     local procedure cdboxlinkOnFormat()
//     begin
//         if Rec.identation = 0 then
//             cd_box_linkEmphasize := true;

//         if Rec.identation > 0 then
//             cd_box_linkIndent := Rec.identation * 300;
//     end;
// }

