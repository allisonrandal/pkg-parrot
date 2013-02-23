<?xml version='1.0'?>
<xsl:stylesheet 
  xmlns:past="http://www.parrotcode.org/PAST-0.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
>
<!--

$Id: /parrotcode/local/languages/plumhead/src/phc/past_xml_to_past_pir.xsl 1801 2007-02-15T06:52:47.129138Z chromatic  $

This transformation takes an abstract syntax tree as generated 
by phc_xml_to_past_xml.xsl. It generates a PIR-script that creates
a PAST-pm data structure and runs it with the help of a HLLCompiler.

-->
<xsl:output method='text' />

<xsl:template match="/" >

# Do not edit this file.                                          
# This file has been generated by past_xml_to_past_pir.xsl
                                                                  
<xsl:call-template name="php-init" />


.sub plumhead :main                                                     
                                                                  
    # look for subs in other namespaces
    .local pmc decode_base64_sub, parse_get_sub, parse_post_sub  
    decode_base64_sub = get_global [ "MIME"; "Base64" ], 'decode_base64'
    parse_get_sub  = get_global [ 'CGI'; 'QueryHash' ], 'parse_get'
    parse_post_sub = get_global [ 'CGI'; 'QueryHash' ], 'parse_post'
    
    # the superglobals
    .local pmc superglobal_GET
    ( superglobal_GET ) = parse_get_sub()
    set_global "_GET", superglobal_GET

    .local pmc superglobal_POST
    ( superglobal_POST ) = parse_post_sub()
    set_global "_POST", superglobal_POST

    # The root node of PAST.
    .local pmc past_node_<xsl:value-of select="generate-id(.)" />                                                  
    past_node_<xsl:value-of select="generate-id(.)" />  = new 'PAST::Block'
    past_node_<xsl:value-of select="generate-id(.)" />.init('name' => 'plumhead_main')

    <xsl:apply-templates />

    # '_dumper'(past_node_<xsl:value-of select="generate-id(.)" />, 'past')
    # '_dumper'(superglobal_POST , 'superglobal_POST')
    # '_dumper'(superglobal_GET , 'superglobal_GET')

    # .local pmc post
    # post = past_node_<xsl:value-of select="generate-id(.)" />.'compile'( 'target' => 'post' )
    # '_dumper'(post, 'post')

    # .local pmc pir
    # pir = past_node_<xsl:value-of select="generate-id(.)" />.'compile'( 'target' => 'pir' )
    # print pir
                                                                  
    .local pmc pastcompiler, eval_past
    pastcompiler = new 'HLLCompiler'
    pastcompiler.'removestage'('parse')
    pastcompiler.'removestage'('past')
    eval_past = pastcompiler.'compile'(past_node_<xsl:value-of select="generate-id(.)" />)
    eval_past()

.end                                                              
                                                                  
</xsl:template>

<xsl:template match="past:Stmts | past:Op | past:Val | past:Var | past:Block" >

  # start of generic node
  .local pmc past_node_<xsl:value-of select="generate-id(.)" />                                                  
  past_node_<xsl:value-of select="generate-id(.)" /> = new '<xsl:choose>
    <xsl:when test="name() = 'past:Block'" >PAST::Block</xsl:when>
    <xsl:when test="name() = 'past:Exp'"   >PAST::Exp</xsl:when>
    <xsl:when test="name() = 'past:Op'"    >PAST::Op</xsl:when>
    <xsl:when test="name() = 'past:Stmt'"  >PAST::Stmt</xsl:when>
    <xsl:when test="name() = 'past:Stmts'" >PAST::Stmts</xsl:when>
    <xsl:when test="name() = 'past:Var'"   >PAST::Var</xsl:when>
                                                            </xsl:choose>'
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates />
  past_node_<xsl:value-of select="generate-id(..)" />.'push'( past_node_<xsl:value-of select="generate-id(.)" /> )      
  null past_node_<xsl:value-of select="generate-id(.)" />
  # end of generic node

</xsl:template>

<xsl:template match="past:Val">

  # start of past:Val
  .local pmc past_node_<xsl:value-of select="generate-id(.)" />
  past_node_<xsl:value-of select="generate-id(.)" /> = new 'PAST::Val'                             
  <xsl:apply-templates select="@name"/>
  <xsl:apply-templates select="@ctype"/>
  <xsl:apply-templates select="@vtype"/>
  past_node_<xsl:value-of select="generate-id(..)" />.'push'( past_node_<xsl:value-of select="generate-id(.)" /> )      
  # end of past:Val

</xsl:template>

<!-- handle attributes -->
<xsl:template match="@name">
  <xsl:choose>
    <xsl:when test="../@encoding = 'base64'" >
      .local string decoded
      decoded = decode_base64_sub( "<xsl:value-of select="." />" )
      past_node_<xsl:value-of select="generate-id(..)" />.'attr'( '<xsl:value-of select="name()" />', decoded, 1 )                              
      null decoded
    </xsl:when>
    <xsl:otherwise>
      past_node_<xsl:value-of select="generate-id(..)" />.'attr'( '<xsl:value-of select="name()" />', '<xsl:value-of select="." />', 1 )                              
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="@*">
  past_node_<xsl:value-of select="generate-id(..)" />.'attr'( '<xsl:value-of select="name()" />', '<xsl:value-of select="." />', 1 )                              
</xsl:template>

<xsl:template name="php-init" >

.sub 'php_init' :load :init

  load_bytecode 'languages/plumhead/src/common/plumheadlib.pbc'
  load_bytecode 'PAST-pm.pbc'                                        
  load_bytecode 'Parrot/HLLCompiler.pbc'
  load_bytecode 'MIME/Base64.pbc'              
  load_bytecode 'dumper.pbc'
  load_bytecode 'CGI/QueryHash.pbc'

.end

</xsl:template>

</xsl:stylesheet>