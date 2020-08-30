/*
 * Copyright 2019 ConsenSys AG.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */
package tech.pegasys.ethsigner.tests.dsl.utils;

import static org.assertj.core.api.Assertions.fail;

import java.io.IOException;

public class ExceptionUtils {

  @FunctionalInterface
  public interface OperationThatMayThrowIOException<R> {
    R execute() throws IOException;
  }

  public static <R extends Object> R failOnIOException(
      final OperationThatMayThrowIOException<R> function) {
    try {
      return function.execute();
    } catch (final IOException e) {
      fail("Unexpected IOException", e);
    }

    return null;
  }
}
