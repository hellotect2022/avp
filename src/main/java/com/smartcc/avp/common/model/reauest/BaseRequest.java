package com.smartcc.avp.common.model.reauest;

import org.springframework.web.bind.MethodArgumentNotValidException;

import com.smartcc.avp.common.model.ApiException;


/*
 * Default Validate Annotaion
 * @AssertFalse : false 값만 통과 가능
 * @AssertTrue : true 값만 통과 가능
 * @DecimalMax(value=) : 지정된 값 이하의 실수만 통과 가능
 * @DecimalMin(value=) : 지정된 값 이상의 실수만 통과 가능
 * @Digits(integer=,fraction=) : 대상 수가 지정된 정수와 소수 자리수보다 적을 경우 통과 가능
 * @Future : 대상 날짜가 현재보다 미래일 경우만 통과 가능
 * @Past : 대상 날짜가 현재보다 과거일 경우만 통과 가능
 * @Max(value) : 지정된 값보다 아래일 경우만 통과 가능
 * @Min(value) : 지정된 값보다 이상일 경우만 통과 가능
 * @NotNull : null 값이 아닐 경우만 통과 가능
 * @Null : null일 경우만 통과 가능
 * @Pattern(regex=, flag=) : 해당 정규식을 만족할 경우만 통과 가능
 * @Size(min=, max=) : 문자열 또는 배열이 지정된 값 사이일 경우 통과 가능
 * @Valid : 대상 객체의 확인 조건을 만족할 경우 통과 가능
 *
 * Custom constraints provided by Hibernate Validator
 * @CreditCardNumber	String	Checks that the annotated string passes the Luhn checksum test. Note, this validation aims to check for user mistakes, not credit card validity! See also Anatomy of Credit Card Numbers.	none
 * @Email	String	Checks whether the specified string is a valid email address.	none
 * @Length(min=, max=)	String	Validates that the annotated string is between min and max included.	Column length will be set to max.
 * @NotBlank	String	Checks that the annotated string is not null and the trimmed length is greater than 0. The difference to @NotEmpty is that this constraint can only be applied on strings and that trailing whitespaces are ignored.	none
 * @NotEmpty	String, Collection, Map and arrays	Checks whether the annotated element is not null nor empty.	none
 * @Range(min=, max=)	BigDecimal, BigInteger, String, byte, short, int, long and the respective wrappers of the primitive types	Checks whether the annotated value lies between (inclusive) the specified minimum and maximum.	none
 * @SafeHtml(whitelistType=, additionalTags=)	CharSequence	Checks whether the annotated value contains potentially malicious fragments such as <script/>. In order to use this constraint, the jsoup library must be part of the class path. With the whitelistType attribute predefined whitelist types can be chosen. You can also specify additional html tags for the whitelist with the additionalTags attribute.	none
 * @ScriptAssert(lang=, script=, alias=)	Any type	Checks whether the given script can successfully be evaluated against the annotated element. In order to use this constraint, an implementation of the Java Scripting API as defined by JSR 223 ("Scripting for the JavaTM Platform") must part of the class path. This is automatically the case when running on Java 6. For older Java versions, the JSR 223 RI can be added manually to the class path.The expressions to be evaluated can be written in any scripting or expression language, for which a JSR 223 compatible engine can be found in the class path.	none
 * @URL(protocol=, host=, port=, regexp=, flags=)	String	Checks if the annotated string is a valid URL according to RFC2396. If any of the optional parameters protocol, host or port are specified, the corresponding URL fragments must match the specified values. The optional parameters regexp and flags allow to specify an additional regular expression (including regular expression flags) which the URL must match.
 * */
public interface BaseRequest {

	public void validate() throws MethodArgumentNotValidException, ApiException;
}
