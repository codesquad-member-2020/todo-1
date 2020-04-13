package com.codesquad.todo1.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.*;

public class JwtUtils {

    private static final String JWT_KEY = "A";

    public static String jwtCreate(String userId) {
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");

        Map<String, Object> payloads = new HashMap<>();
        payloads.put("userId", userId);

        String jwt = Jwts.builder()
                .setHeader(headers)
                .setClaims(payloads)
                .signWith(SignatureAlgorithm.HS256, JWT_KEY.getBytes())
                .compact();
        return jwt;
    }

    public static String jwtParsing(String jwt) {
        Claims claims = Jwts.parser()
                .setSigningKey(JWT_KEY.getBytes())
                .parseClaimsJws(jwt)
                .getBody();
        return claims.get("userId", String.class);
    }
}
