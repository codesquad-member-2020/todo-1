package com.codesquad.todo1.Utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.*;

public class JwtUtils {
    public static String jwtCreate(String userId) {
        String key = "A";
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");

        Map<String, Object> payloads = new HashMap<>();
        Long expiredTime = 1000 * 60L;
        Date now = new Date();
        now.setTime(now.getTime() + expiredTime);
        payloads.put("exp", now);
        payloads.put("userId", userId);

        String jwt = Jwts.builder()
                .setHeader(headers)
                .setClaims(payloads)
                .signWith(SignatureAlgorithm.HS256, key.getBytes())
                .compact();
        return jwt;
    }

    public static String jwtParsing(String jwt) {
        Claims claims = Jwts.parser()
                .setSigningKey("A".getBytes())
                .parseClaimsJws(jwt)
                .getBody();
        return claims.get("userId", String.class);
    }

}
