<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" Inherits="Account_Register" Codebehind="Cliente.aspx.cs" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
     <script type ="text/javascript" >
        

         function pwdStr() {
             var options = {
                 onLoad: function () {
                     /*$('#messages').text('Start typing password');*/
                    
                   
                 },
                 onKeyUp: function (evt) {
                     $(evt.target).pwstrength("outputErrorList");
                    
                 }                
                 
             };
             
             $("#Senha").pwstrength(options);
             $("#Senha").pwstrength("forceUpdate");
         }   

         (function ($) {
             "use strict";

             var options = {
                 errors: [],
                 // Options
                 minChar: 8,
                 errorMessages: {
                     password_to_short: "A senha digitada é muito curta",
                     same_as_username: "Sua senha não pode ser igual ao seu login"
                 },
                 scores: [17, 26, 40, 50],
                 verdicts: ["Fraca", "Normal", "Razoável", "Forte", "Muito Forte"],
                 showVerdicts: true,
                 raisePower: 1.4,
                 usernameField: "#Email",
                 onLoad: undefined,
                 onKeyUp: undefined,
                 viewports: {
                     progress: undefined,
                     verdict: undefined,
                     errors: undefined
                 },
                 // Rules stuff
                 ruleScores: {
                     wordNotEmail: -100,
                     wordLength: -100,
                     wordSimilarToUsername: -100,
                     wordLowercase: 1,
                     wordUppercase: 3,
                     wordOneNumber: 3,
                     wordThreeNumbers: 5,
                     wordOneSpecialChar: 3,
                     wordTwoSpecialChar: 5,
                     wordUpperLowerCombo: 2,
                     wordLetterNumberCombo: 2,
                     wordLetterNumberCharCombo: 2
                 },
                 rules: {
                     wordNotEmail: true,
                     wordLength: true,
                     wordSimilarToUsername: true,
                     wordLowercase: true,
                     wordUppercase: true,
                     wordOneNumber: true,
                     wordThreeNumbers: true,
                     wordOneSpecialChar: true,
                     wordTwoSpecialChar: true,
                     wordUpperLowerCombo: true,
                     wordLetterNumberCombo: true,
                     wordLetterNumberCharCombo: true
                 },
                 validationRules: {
                     wordNotEmail: function (options, word, score) {
                         return word.match(/^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i) && score;
                     },
                     wordLength: function (options, word, score) {
                         var wordlen = word.length,
                             lenScore = Math.pow(wordlen, options.raisePower);
                         if (wordlen < options.minChar) {
                             lenScore = (lenScore + score);
                             /*options.errors.push(options.errorMessages.password_to_short);*/

                         }
                         return lenScore;
                     },
                     wordSimilarToUsername: function (options, word, score) {
                         var username = $(options.usernameField).val();
                         if (username && word.toLowerCase().match(username.toLowerCase())) {
                             options.errors.push(options.errorMessages.same_as_username);
                             return score;
                         }
                         return true;
                     },
                     wordLowercase: function (options, word, score) {
                         return word.match(/[a-z]/) && score;
                     },
                     wordUppercase: function (options, word, score) {
                         return word.match(/[A-Z]/) && score;
                     },
                     wordOneNumber: function (options, word, score) {
                         return word.match(/\d+/) && score;
                     },
                     wordThreeNumbers: function (options, word, score) {
                         return word.match(/(.*[0-9].*[0-9].*[0-9])/) && score;
                     },
                     wordOneSpecialChar: function (options, word, score) {
                         return word.match(/.[!,@,#,$,%,\^,&,*,?,_,~]/) && score;
                     },
                     wordTwoSpecialChar: function (options, word, score) {
                         return word.match(/(.*[!,@,#,$,%,\^,&,*,?,_,~].*[!,@,#,$,%,\^,&,*,?,_,~])/) && score;
                     },
                     wordUpperLowerCombo: function (options, word, score) {
                         return word.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/) && score;
                     },
                     wordLetterNumberCombo: function (options, word, score) {
                         return word.match(/([a-zA-Z])/) && word.match(/([0-9])/) && score;
                     },
                     wordLetterNumberCharCombo: function (options, word, score) {
                         return word.match(/([a-zA-Z0-9].*[!,@,#,$,%,\^,&,*,?,_,~])|([!,@,#,$,%,\^,&,*,?,_,~].*[a-zA-Z0-9])/) && score;
                     }
                 }
             },

                 setProgressBar = function ($el, score) {
                     var options = $el.data("pwstrength"),
                         progressbar = options.progressbar,
                         $verdict;

                     if (options.showVerdicts) {
                         if (options.viewports.verdict) {
                             $verdict = $(options.viewports.verdict).find(".password-verdict");
                         } else {
                             $verdict = $el.parent().find(".password-verdict");
                             if ($verdict.length === 0) {
                                 $verdict = $('<span class="password-verdict" style="color:black"></span>');
                                 $verdict.insertAfter($el);
                             }
                         }
                     }

                     if (score < options.scores[0]) {
                         progressbar.find(".progress-bar").addClass("progress-bar-danger").removeClass("progress-bar-warning").removeClass("progress-bar-success");
                         progressbar.find(".progress-bar").css('width', 5 + '%').attr('aria-valuenow', 5);
                         if (options.showVerdicts) {
                             $verdict.text(options.verdicts[0]);
                             $verdict.css('color', "red");
                         }

                     } else if (score >= options.scores[0] && score < options.scores[1]) {
                         progressbar.find(".progress-bar").addClass("progress-bar-danger").removeClass("progress-bar-warning").removeClass("progress-bar-success");
                         progressbar.find(".progress-bar").css('width', 25 + '%').attr('aria-valuenow', 25);
                         if (options.showVerdicts) {
                             $verdict.text(options.verdicts[1]);
                             $verdict.css('color', "red");
                         }
                     } else if (score >= options.scores[1] && score < options.scores[2]) {
                         progressbar.find(".progress-bar").addClass("progress-bar-warning").removeClass("progress-bar-danger").removeClass("progress-bar-success");
                         progressbar.find(".progress-bar").css('width', 50 + '%').attr('aria-valuenow', 50);
                         if (options.showVerdicts) {
                             $verdict.text(options.verdicts[2]);
                             $verdict.css('color', "orange");
                         }
                     } else if (score >= options.scores[2] && score < options.scores[3]) {
                         progressbar.find(".progress-bar").addClass("progress-bar-warning").removeClass("progress-bar-danger").removeClass("progress-bar-success");
                         progressbar.find(".progress-bar").css('width', 75 + '%').attr('aria-valuenow', 75);
                         if (options.showVerdicts) {
                             $verdict.text(options.verdicts[3]);
                             $verdict.css('color', "orange");
                         }
                     } else if (score >= options.scores[3]) {
                         progressbar.find(".progress-bar").addClass("progress-bar-success").removeClass("progress-bar-warning").removeClass("progress-bar-danger");
                         progressbar.find(".progress-bar").css('width', 100 + '%').attr('aria-valuenow', 100);
                         if (options.showVerdicts) {
                             $verdict.text(options.verdicts[4]);
                             $verdict.css('color', "green");

                         }
                     }
                 },

                 calculateScore = function ($el) {
                     var self = this,
                         word = $el.val(),
                         totalScore = 0,
                         options = $el.data("pwstrength");

                     $.each(options.rules, function (rule, active) {
                         if (active === true) {
                             var score = options.ruleScores[rule],
                                 result = options.validationRules[rule](options, word, score);
                             if (result) {
                                 totalScore += result;
                             }
                         }
                     });
                     setProgressBar($el, totalScore);

                     return totalScore;
                 },

                 progressWidget = function () {
                     return '<div class="progress active"><div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 5%;"></div></div>';
                 },

                 methods = {
                     init: function (settings) {
                         var self = this,
                             allOptions = $.extend(options, settings);

                         return this.each(function (idx, el) {
                             var $el = $(el),
                                 progressbar,
                                 verdict;

                             $el.data("pwstrength", allOptions);

                             $el.on("keyup", function (event) {
                                 var options = $el.data("pwstrength");
                                 options.errors = [];
                                 calculateScore.call(self, $el);
                                 if ($.isFunction(options.onKeyUp)) {
                                     options.onKeyUp(event);
                                 }
                             });

                             progressbar = $(progressWidget());
                             if (allOptions.viewports.progress) {
                                 $(allOptions.viewports.progress).append(progressbar);
                             } else {
                                 progressbar.insertAfter($el);
                             }
                             progressbar.find(".progress-bar").css('width', 0 + '%').attr('aria-valuenow', 0);
                             $el.data("pwstrength").progressbar = progressbar;

                             if (allOptions.showVerdicts) {
                                 verdict = $('<span class="password-verdict" style="color:red">' + allOptions.verdicts[0] + '</span>');
                                 if (allOptions.viewports.verdict) {
                                     $(allOptions.viewports.verdict).append(verdict);
                                 } else {
                                     verdict.insertAfter($el);
                                 }
                             }

                             if ($.isFunction(allOptions.onLoad)) {
                                 allOptions.onLoad();
                             }
                         });
                     },

                     destroy: function () {
                         this.each(function (idx, el) {
                             var $el = $(el);
                             $el.parent().find("span.password-verdict").remove();
                             $el.parent().find("div.progress").remove();
                             $el.parent().find("ul.error-list").remove();
                             $el.removeData("pwstrength");
                         });
                     },

                     forceUpdate: function () {
                         var self = this;
                         this.each(function (idx, el) {
                             var $el = $(el),
                                 options = $el.data("pwstrength");
                             options.errors = [];
                             calculateScore.call(self, $el);
                         });
                     },

                     outputErrorList: function () {
                         this.each(function (idx, el) {
                             var output = '<ul class="error-list">',
                                 $el = $(el),
                                 errors = $el.data("pwstrength").errors,
                                 viewports = $el.data("pwstrength").viewports,
                                 verdict;
                             $el.parent().find("ul.error-list").remove();

                             if (errors.length > 0) {
                                 $.each(errors, function (i, item) {
                                     output += '<li>' + item + '</li>';
                                 });
                                 output += '</ul>';
                                 if (viewports.errors) {
                                     $(viewports.errors).html(output);
                                 } else {
                                     output = $(output);
                                     verdict = $el.parent().find("span.password-verdict");
                                     if (verdict.length > 0) {
                                         el = verdict;
                                     }
                                     output.insertAfter(el);
                                 }
                             }
                         });
                     },

                     addRule: function (name, method, score, active) {
                         this.each(function (idx, el) {
                             var options = $(el).data("pwstrength");
                             options.rules[name] = active;
                             options.ruleScores[name] = score;
                             options.validationRules[name] = method;
                         });
                     },

                     changeScore: function (rule, score) {
                         this.each(function (idx, el) {
                             $(el).data("pwstrength").ruleScores[rule] = score;
                         });
                     },

                     ruleActive: function (rule, active) {
                         this.each(function (idx, el) {
                             $(el).data("pwstrength").rules[rule] = active;
                         });
                     }
                 };

             $.fn.pwstrength = function (method) {
                 var result;
                 if (methods[method]) {
                     result = methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
                 } else if (typeof method === "object" || !method) {
                     result = methods.init.apply(this, arguments);
                 } else {
                     $.error("O metódo " + method + " não existe no jQuery.pwstrength");
                 }
                 return result;
             };

         }(jQuery));
         function removeBarra() {
             $("#Senha").pwstrength("destroy");
         }
 </script>
 

    <h2>Registrando-se</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
        
     </p>
    <div  class="form-horizontal">
       
        <h4>Preencha o fórmulario para cadastrar-se</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="CPF_CNPJ" CssClass="col-md-2 control-label">CNPJ / CPF</asp:Label>
            <div class="col-md-4">
                <asp:TextBox runat="server" ID="CPF_CNPJ" CssClass="form-control" ClientIDMode="Static"/>              
                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="CPF_CNPJ"
                   CssClass="text-danger" ErrorMessage="O CPF ou o CNPJ deve ser preenchido" />
            </div>
            <div class="col-md-2 col-md-pull-1">
                 
                <label><span>CPF:</span><input type="radio" name="tipo" value="cpf" checked="checked"></label>
                <label><span>CNPJ:</span><input type="radio" name="tipo" value="cnpj"></label>
             </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Nome_Razao_Social" CssClass="col-md-2 control-label">Razão Social / Nome</asp:Label>
            <div class="col-md-5">
                <asp:TextBox runat="server" ID="Nome_Razao_Social" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Nome_Razao_Social"
                    CssClass="text-danger" ErrorMessage="O nome ou a razão social da sua empresa deve ser preenchido"  />
            </div>
        </div>
        
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="CEP" CssClass="col-md-2 control-label">CEP</asp:Label>
            <div class="col-md-4">
                <asp:TextBox runat="server" ID="CEP" AutoPostBack="true" OnTextChanged="CEP_Click" CssClass="form-control" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="CEP"
                    CssClass="text-danger" ErrorMessage="O CEP deve ser preenchido"  />                
            </div>
            
        </div>
        
       
       
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
                     <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Bairro" CssClass="col-md-2 control-label">Bairro</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Bairro" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Bairro"
                                CssClass="text-danger" ErrorMessage="O bairro deve ser preenchido"  />
                        </div>
                    </div>    
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Cidade" CssClass="col-md-2 control-label">Cidade</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Cidade" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Cidade"
                                CssClass="text-danger" ErrorMessage="A cidade deve ser preenchida"  />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Logradouro" CssClass="col-md-2 control-label">Logradouro</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Logradouro" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Logradouro"
                                CssClass="text-danger" ErrorMessage="O logradouro deve ser preenchido"  />
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CEP" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>
         <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Numero" CssClass="col-md-2 control-label">Número</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Numero" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Numero"
                    CssClass="text-danger" ErrorMessage="O número deve ser preenchido"  />
            </div>
        </div>
        <div class="form-group">
            
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">E-mail</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                <asp:RegularExpressionValidator runat="server"  Display="Dynamic"  ControlToValidate="Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  CssClass="text-danger" ErrorMessage="O E-mail preenchido não é válido" />
                <asp:RequiredFieldValidator runat="server"  Display="Dynamic" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="O E-mail deve ser preenchido"  />
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                
                <div class="form-group" id="divSenha">
                    <asp:Label runat="server" AssociatedControlID="Senha"   CssClass="col-md-2 control-label">Senha</asp:Label>
                       <div class="col-md-4">
                            <asp:TextBox runat="server" ID="Senha" AutoPostBack="true"  OnTextChanged="Senha_TextChanged" ValidationGroup="validaSenha"  TextMode="Password" ClientIDMode="Static" CssClass="form-control" />  
                            <asp:RegularExpressionValidator ValidationGroup="validaSenha" runat="server" ValidateRequestMode="Enabled" ControlToValidate="Senha" ValidationExpression="((?=.*[A-Z])(?=.*\d).{6,20} |(?=.*[a-z])(?=.*\d).{8,20}|(?=.*[!@#$%^&*])(?=.*\d).{8,20}|(?=.*[A-Z])(?=.*\d).{8,20}|(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,20}|(?=.*[a-z])(?=.*[!@#$%^&*]).{8,20}|(?=.*[A-Z])(?=.*[a-z]).{8,20})"            
                             Display="Dynamic" CssClass="text-danger" ErrorMessage="Senha fora dos padrões de segurança"  />
                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="Senha"
                             CssClass="text-danger" ErrorMessage="Preencha sua senha"  />                
                       </div>                                  
                    </div>
                    
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Senha" EventName="TextChanged" />
                </Triggers>
         </asp:UpdatePanel>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirma senha</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Preencha a confirmação da senha" />
                <asp:CompareValidator runat="server" ControlToCompare="Senha" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="As senhas não correspondem" />
            </div>
        </div>
        
        <div class="form-group">
                        
            <asp:Label runat="server" AssociatedControlID="Tipo" CssClass="col-md-2 control-label">Tipo</asp:Label>
            <div class ="col-md-3 col-md-pull-0 ">
                  <asp:DropDownList ID="Tipo" runat="server" CssClass="form-control">
                        <asp:ListItem Value="2">Anunciante</asp:ListItem>
                        <asp:ListItem Value="3">Exibidor</asp:ListItem>
                    </asp:DropDownList>                   
                </div>
        </div>   
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Registra" CssClass="btn btn-primary"  />
                <asp:Button runat="server" OnClick="CleanAll_Click" Text="Limpa" CssClass="btn btn-default " CausesValidation="False" UseSubmitBehavior="False" ValidateRequestMode="Disabled" />
                
            </div>
        </div>
       
    </div>
    <script src="Scripts/jquery.maskedinput.min.js"></script>
    
  <script type="text/javascript" >

      $(document).ready(function() {
         
          $("#CEP").mask("99999-999");
          $("#CPF_CNPJ").mask("999.999.999-99");//Inicia o campo como CPF
          $("input[name=tipo]:radio").change(function () {
              $("#CPF_CNPJ").unmask();//Remove a mascara
              if ($(this).val() == "cpf") {//Caso seja CPF
                  $("#CPF_CNPJ").mask("999.999.999-99");
              } else {//Caso seja Cnpj
                  $("#CPF_CNPJ").mask("99.999.999/9999-99");
              }
          })
    
      });

      </script>

<script src="Scripts/bootbox.min.js"> </script>
<script type="text/javascript">
    function showMyDialog(){
    bootbox.dialog({
        message: "A senha digitada não satisfaz os requisitos de complexidade, por favor digite uma senha que satisfaça os requisitos a seguir:"+'<br/>'+      
    "1. Não conter partes significativas do nome da conta do usuário ou o nome todo."+'<br/>'+              
    "2. Ter pelo menos oito caracteres de comprimento."+'<br/>'+             
    "3. Conter caracteres de duas das quatro categorias a seguir:"+'<br/>'+              
    "* Caracteres maiúsculos da língua portuguesa (A-Z)"+'<br/>'+              
    "* Caracteres minúsculos da língua portuguesa (a-z)"+'<br/>'+              
    "* Dígitos básicos (0-9)"+'<br/>'+              
    "* Caracteres não-alfabéticos (por exemplo, ! $, #, %)",
        title: "Por favor, corrija sua senha",
        buttons: {
            success: {
                label: "Ok",
                className: "btn-primary",
                callback: function () {
                    bootbox.hideAll()
                    
                }
            }
        }
    });
  }
</script> 
  
</asp:Content>

